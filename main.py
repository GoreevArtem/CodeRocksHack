from db import QUERY, QUERY_GET
import psycopg2
from psycopg2 import Error
from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT

import os
import streamlit as st
import requests
import dotenv


path = "sourse"
if not(os.path.isdir(path)):
    os.mkdir(path) 

dotenv.load_dotenv(dotenv.find_dotenv())

'''
### Панель администратора телеграм бота
'''

def send_message(text: str, ID_CHAT = os.getenv('ID_CHAT')):
    url = 'https://api.telegram.org/bot' + os.getenv('TOKEN') + "/sendMessage" + "?chat_id=" + ID_CHAT + "&text=" + text
    requests.get(url)

login, password = st.text_input("Введите логин:"), st.text_input("Введите пароль:", type="password")

try:
    connection = psycopg2.connect(os.getenv('DATABASE'))
    connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

    def get_auth(login):
        return QUERY_GET(connection=connection, query = f"""SELECT full_name FROM public."Employee" WHERE full_name = '{login}'""", param = True)

    if bool(get_auth(login=login)) and password=="123":

        option = st.selectbox(
            "Выбери действие",
            ("Посты", "Сотрудники", "Инструкции", "Вопросы"),
            )
        if option == "Посты":
            TextBox = st.text_area('Введи новый пост')
            
            if st.button('Опубликовать'):
                send_message(TextBox)
                st.success('Пост опубликован')

            '''
            ----
            '''

            uploaded_files = st.file_uploader("Выбери файлы", accept_multiple_files=True)
            count = 0
            for uploaded_file in uploaded_files:
                with open(os.path.join(path, uploaded_file.name),"wb") as file:
                    file.write(uploaded_file.getbuffer())
                st.success(uploaded_file.name + " данные сохранились на сервере")

            '''
            ----
            '''

            st.write('Изменить ссылку на фотографию')
            name = st.text_input("ФИО сотрудника")         

            new = st.text_input("Новая ссылка")
            if name != "" and new != "":
                QUERY(connection=connection, query =  f"""UPDATE public."Employee" SET photo = '{ new }' WHERE full_name = '{ name }'""")

        
        if option == "Сотрудники":
            st.write('Список сотрудников')
            all_users = QUERY_GET(connection=connection, query = 'SELECT full_name, person_test_result, notifications FROM public."Employee"', param = True)
            for i, name in enumerate(all_users):
                st.write(name[0])
                if name[2] == 0:
                    if st.button('Отключить уведомления', key=i):
                        QUERY(connection=connection, query =  f"""UPDATE public."Employee" SET notifications = 1 WHERE full_name = '{ name[0] }'""")
                else:
                    if st.button('Включить уведомления', key=i):
                        QUERY(connection=connection, query =  f"""UPDATE public."Employee" SET notifications = 0 WHERE full_name = '{ name[0] }'""")

                st.write(f"Результат опроса {name[1]}")
                
                '''
                ----
                '''

        if option == "Инструкции":
            st.write("Введите ФИО сотрудника, для которого нужно изменить должностную инструкцию")
            name = st.text_input("ФИО сотрудника") 
            text = st.text_area('Изменить инструкцию 1')
            if st.button('Изменить'):
                QUERY(connection, f"""UPDATE public."Employee" SET duties = '{ text }' WHERE full_name = '{ name }'""")
                st.success('Инструкция изменена')
        
        if option == "Вопросы":
            st.write("Посмотреть вопросы")

            query = QUERY_GET(connection=connection, query = 'SELECT full_name, question FROM public."Employee" where question is not null', param = True)

            for i in query:
                st.warning(i[0])
                st.write(i[1])
                text = st.text_area('Ответ', key=i)
                if text != "":
                    chat = QUERY_GET(connection=connection, query = f"""SELECT id_chat, notifications FROM public."Employee" WHERE full_name = '{ i[0] }'""", param = True)
                    
                    QUERY(connection=connection, query = f"""UPDATE public."Employee" SET question = null WHERE full_name = '{ i[0] }'""")
                    if chat[0][1] == 1:
                        send_message(text, "&disable_notification=false")
                    else:
                        send_message(text)
                    st.success(f'Вы ответили на вопрос пользователю {i[0]}')
except Error as e:
    st.error("Ошибка сервера", e)
    if connection:
        connection.close()