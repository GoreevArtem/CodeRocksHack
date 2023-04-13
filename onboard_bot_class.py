from aiogram import Bot, Dispatcher, types
from aiogram.contrib.fsm_storage.memory import MemoryStorage
from aiogram.dispatcher import FSMContext
from aiogram.dispatcher.filters import Text
from aiogram.types.input_file import InputFile
import random

from form_classes import *
from keyboards import *
from database import *

dotenv.load_dotenv(dotenv.find_dotenv())


class OnboardBot:
    __bot: Bot = Bot(token=os.getenv('TOKEN'))
    __storage: MemoryStorage = MemoryStorage()
    __dp: Dispatcher = Dispatcher(__bot, storage=__storage)

    __connection = psycopg2.connect(os.getenv('DATABASE'))
    __connection.set_isolation_level(ISOLATION_LEVEL_AUTOCOMMIT)

    @classmethod
    def get_dp(cls) -> Dispatcher:
        return cls.__dp

    @staticmethod
    def get_random_photo() -> tuple:
        person_ids = QUERY_GET(OnboardBot.__connection,
                               query=f"""SELECT id FROM public."Employee" """, param=True)
        random_id = random.choice(person_ids)[0]
        random_photo = QUERY_GET(OnboardBot.__connection,
                                 query=f"""SELECT photo FROM public."Employee" WHERE id = '{random_id}' """)
        photo = InputFile(random_photo[0])
        return photo, random_id

    @staticmethod
    async def validate_answer(message: types.Message, state: FSMContext):
        person_id = await state.get_data()
        real_full_name = QUERY_GET(OnboardBot.__connection,
                                 query=f"""SELECT full_name FROM public."Employee" 
                                 WHERE id = '{person_id["random_id"]}' """)
        if real_full_name[0] == message.text:
            QUERY(OnboardBot.__connection,
                  query=f"""UPDATE public."Employee" SET person_test_result = person_test_result + 1 
                  WHERE id_chat = '{message.chat.id}' """)
            await message.answer("Совершенно верно!")
        else:
            await message.answer("Неверно!")


    """
    Блок стартового диалога
    """

    @staticmethod
    @__dp.message_handler(commands=["start"], state="*")
    async def cmd_start(message: types.Message):
        
        await StartDialogForm.employee.set()
        await message.reply("Укажите свое ФИО", reply_markup=types.ReplyKeyboardRemove())

    @staticmethod
    @__dp.message_handler(Text, state=StartDialogForm.employee)
    async def process_full_name(message: types.Message, state: FSMContext):
        if QUERY_GET(OnboardBot.__connection,
                     query=f"""SELECT * FROM public."Employee" WHERE full_name = '{message.text}'""", param=True):
            QUERY(OnboardBot.__connection,
                  query=f"""UPDATE public."Employee" SET id_chat = '000' WHERE id_chat = '{message.chat.id}' """)
            QUERY(OnboardBot.__connection,
                  query=f"""UPDATE public."Employee" SET id_chat = '{message.chat.id}' 
                  WHERE full_name = '{message.text}' """)
            
            await state.finish()
            await MainDialogForm.main.set()
            await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)
        else:
            await message.reply("Повторите ввод")

    """
    Блок "Об офисе"
    """

    @staticmethod
    @__dp.message_handler(Text(equals=MainKeyboard.buttons["btn_about_office"], ignore_case=True),
                          state=MainDialogForm.main)
    async def process_about_office(message: types.Message, state: FSMContext):
        await message.answer("Выберите раздел", reply_markup=AboutOfficeKeyboard.about_office_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=AboutOfficeKeyboard.buttons["btn_office_video"], ignore_case=True),
                          state=MainDialogForm.main)
    async def process_office_video(message: types.Message, state: FSMContext):
        video_path = QUERY_GET(OnboardBot.__connection,
                               query=f"""SELECT video FROM public."Office" """, param=False)
        video = InputFile(video_path[0])
        await OnboardBot.__bot.send_video(chat_id=message.chat.id, video=video)
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=AboutOfficeKeyboard.buttons["btn_floor_plan"], ignore_case=True),
                          state=MainDialogForm.main)
    async def process_floor_plan(message: types.Message, state: FSMContext):
        photo_path = QUERY_GET(OnboardBot.__connection,
                               query=f"""SELECT plan FROM public."Office" """, param=False)
        photo = InputFile(photo_path[0])
        await OnboardBot.__bot.send_photo(chat_id=message.chat.id, photo=photo)
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    """
    Блок "Сотрудники"
    """

    @staticmethod
    @__dp.message_handler(Text(equals=MainKeyboard.buttons["btn_employees"], ignore_case=True),
                          state=MainDialogForm.main)
    async def process_employees(message: types.Message, state: FSMContext):
        await state.finish()
        await EmployeesDialogForm.employees.set()
        await message.answer("Выберите раздел", reply_markup=EmployeesKeyboard.employees_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=EmployeesKeyboard.buttons["btn_all_employees"], ignore_case=True),
                          state=EmployeesDialogForm.employees)
    async def process_employees_all(message: types.Message, state: FSMContext):
        our_id = message.chat.id
        data = QUERY_GET(OnboardBot.__connection,
                         query=f"""SELECT full_name, competencies FROM public."Employee" WHERE id_chat != '{our_id}'""",
                         param=True)
        await message.answer(
            "ФИО сотрудника \t|\t Компетенция сотрудника\n\n" + "\n\n".join([f"{i[0]} \t|\t {i[1]}" for i in data]))
        await message.answer("Выберите раздел", reply_markup=CommonEmployeesKeyboard.common_employees_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=EmployeesKeyboard.buttons["btn_my_department"], ignore_case=True),
                          state=EmployeesDialogForm.employees)
    async def process_employees_all(message: types.Message, state: FSMContext):
        our_id = message.chat.id
        our_department = QUERY_GET(OnboardBot.__connection,
                                   query=f"""SELECT department FROM public."Employee" WHERE id_chat = '{our_id}'""")
        data = QUERY_GET(OnboardBot.__connection,
                         query=f"""SELECT full_name, competencies FROM public."Employee" 
                         WHERE id_chat != '{our_id}' AND department = '{our_department[0]}' """,
                         param=True)
        await message.answer(
            "ФИО сотрудника \t|\t Компетенция сотрудника\n\n" + "\n\n".join([f"{i[0]} \t {i[1]}" for i in data]))
        await message.answer("Выберите раздел", reply_markup=CommonEmployeesKeyboard.common_employees_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=CommonEmployeesKeyboard.buttons["btn_detail"], ignore_case=True),
                          state=EmployeesDialogForm.employees)
    async def process_employees_detail(message: types.Message, state: FSMContext):
        await EmployeesDialogForm.detail.set()
        await message.answer("Введите ФИО интересующего сотрудника", reply_markup=types.ReplyKeyboardRemove())

    @staticmethod
    @__dp.message_handler(Text, state=EmployeesDialogForm.detail)
    async def process_employees_detail_info(message: types.Message, state: FSMContext):
        data = QUERY_GET(OnboardBot.__connection,
                         query=f"""SELECT * FROM public."Employee" WHERE full_name = '{message.text}'""")
        if data:
            photo = InputFile(data[4])
            await OnboardBot.__bot.send_photo(chat_id=message.chat.id, photo=photo)
            await message.answer(
                f"ФИО:\n{data[5]}\n\nКомпетенции:\n{data[2]}\n\nДолжностные обязанности:\n{data[3]}\n\n"
                f"Достижения:\n{data[6]}")
            await state.finish()
            await MainDialogForm.main.set()
            await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)
        else:
            await message.answer("Такого человека не существует, повторите ввод.")

    @staticmethod
    @__dp.message_handler(Text(equals=CommonEmployeesKeyboard.buttons["btn_to_main"], ignore_case=True),
                          state=EmployeesDialogForm.employees)
    async def process_employees_to_main(message: types.Message, state: FSMContext):
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    """
    Блок "О компании"
    """

    @staticmethod
    @__dp.message_handler(Text(equals=MainKeyboard.buttons["btn_about_company"], ignore_case=True),
                          state=MainDialogForm.main)
    async def process_about_company(message: types.Message, state: FSMContext):
        data = QUERY_GET(OnboardBot.__connection,
                         query=f"""SELECT * FROM public."Company" """)
        await message.answer(
            f"О компании:\n\n{data[1]}\n\nНаправление работы:\n\n{data[2]}\n\nАдрес:\n\n{data[3]}\n\n"
            f"Контактный телефон:\n\n{data[4]}\n\nВремя работы:\n\n{data[5]}")
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    """
    Блок "Продукты компании"
    """

    @staticmethod
    @__dp.message_handler(Text(equals=MainKeyboard.buttons["btn_company_products"], ignore_case=True),
                          state=MainDialogForm.main)
    async def process_products(message: types.Message, state: FSMContext):
        await state.finish()
        await ProductsDialogForm.products.set()
        await message.answer("Выберите раздел", reply_markup=CompanyProductsKeyboard.company_products_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=CompanyProductsKeyboard.buttons["btn_to_main"], ignore_case=True),
                          state=ProductsDialogForm.products)
    async def process_products_to_main(message: types.Message, state: FSMContext):
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=(CompanyProductsKeyboard.buttons["btn_kids"],
                                       CompanyProductsKeyboard.buttons["btn_junior"],
                                       CompanyProductsKeyboard.buttons["btn_middle"],
                                       CompanyProductsKeyboard.buttons["btn_senior"]), ignore_case=True),
                          state=ProductsDialogForm.products)
    async def process_products_category(message: types.Message, state: FSMContext):
        await state.set_data({"product_category": message.text})
        await message.answer("Выберите раздел", reply_markup=CommonProductKeyboard.common_product_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=CommonProductKeyboard.buttons["btn_program"], ignore_case=True),
                          state=ProductsDialogForm.products)
    async def process_products_kids_program(message: types.Message, state: FSMContext):
        product_category = await state.get_data()
        data = QUERY_GET(OnboardBot.__connection,
                         query=f"""SELECT * FROM public."Product" 
                         WHERE name = '{product_category["product_category"]}' """)
        await message.answer(
            f"Программа:\n\n{data[1]}\n\nРасчитана на обучающихся в возрасте:\n\n{data[2]}\n\nО программе:\n\n"
            f"{data[5]}\n\nФормат проведения:\n\n{data[6]}\n\nДлительность обучения:\n\n{data[3]}")
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=CommonProductKeyboard.buttons["btn_teachers"], ignore_case=True),
                          state=ProductsDialogForm.products)
    async def process_products_kids_teachers(message: types.Message, state: FSMContext):
        product_category = await state.get_data()
        data = QUERY_GET(OnboardBot.__connection,
                         query=f"""SELECT teachers FROM public."Product" 
                         WHERE name = '{product_category["product_category"]}' """)
        await message.answer(f"{data[0]}")
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=CommonProductKeyboard.buttons["btn_price"], ignore_case=True),
                          state=ProductsDialogForm.products)
    async def process_products_kids_price(message: types.Message, state: FSMContext):
        product_category = await state.get_data()
        data = QUERY_GET(OnboardBot.__connection,
                         query=f"""SELECT cost FROM public."Product" 
                         WHERE name = '{product_category["product_category"]}' """)
        await message.answer(f"Стоимость обучения за месяц:\n\n{data[0]}")
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=CommonProductKeyboard.buttons["btn_back"], ignore_case=True),
                          state=ProductsDialogForm.products)
    async def process_products_kids_back(message: types.Message, state: FSMContext):
        await ProductsDialogForm.products.set()
        await message.answer("Выберите раздел", reply_markup=CompanyProductsKeyboard.company_products_kb)

    """
    Блок "Должностные обязанности"
    """

    @staticmethod
    @__dp.message_handler(Text(equals=MainKeyboard.buttons["btn_official_duties"], ignore_case=True),
                          state=MainDialogForm.main)
    async def process_official_duties(message: types.Message, state: FSMContext):

        data = QUERY_GET(OnboardBot.__connection,
                         query=f"""SELECT duties FROM public."Employee" WHERE id_chat = '{message.chat.id}' """)
        await message.answer(f"Мои должностные обязанности:\n\n{data[0]}")
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    """
    Блок проверки знаний
    """

    @staticmethod
    @__dp.message_handler(Text(equals=MainKeyboard.buttons["btn_test_knowledge"], ignore_case=True),
                          state=MainDialogForm.main)
    async def process_test_knowledge(message: types.Message, state: FSMContext):
        await state.finish()
        await KnowledgeTestDialogForm.knowledge_test.set()
        await message.answer("Выберите раздел", reply_markup=KnowledgeTestKeyboard.knowledge_test_kb)

    @staticmethod
    @__dp.message_handler(Text(equals=KnowledgeTestKeyboard.buttons["btn_people_test"], ignore_case=True),
                          state=KnowledgeTestDialogForm.knowledge_test)
    async def process_test_knowledge_people_1(message: types.Message, state: FSMContext):
        QUERY(OnboardBot.__connection,
              query=f"""UPDATE public."Employee" SET person_test_result = 0 WHERE id_chat = '{message.chat.id}' """)
        await KnowledgeTestDialogForm.people_test_1.set()
        await message.answer("Напишите ФИО этого человека:", reply_markup=types.ReplyKeyboardRemove())

        photo, random_id = OnboardBot.get_random_photo()
        await state.set_data({"random_id": random_id})
        await OnboardBot.__bot.send_photo(chat_id=message.chat.id, photo=photo)

    @staticmethod
    @__dp.message_handler(Text, state=KnowledgeTestDialogForm.people_test_1)
    async def process_test_knowledge_people_2(message: types.Message, state: FSMContext):
        await OnboardBot.validate_answer(message, state)

        await KnowledgeTestDialogForm.people_test_2.set()
        await message.answer("Напишите ФИО этого человека:")

        photo, random_id = OnboardBot.get_random_photo()
        await state.set_data({"random_id": random_id})
        await OnboardBot.__bot.send_photo(chat_id=message.chat.id, photo=photo)

    @staticmethod
    @__dp.message_handler(Text, state=KnowledgeTestDialogForm.people_test_2)
    async def process_test_knowledge_people_3(message: types.Message, state: FSMContext):
        await OnboardBot.validate_answer(message, state)

        await KnowledgeTestDialogForm.people_test_3.set()
        await message.answer("Напишите ФИО этого человека:")

        photo, random_id = OnboardBot.get_random_photo()
        await state.set_data({"random_id": random_id})
        await OnboardBot.__bot.send_photo(chat_id=message.chat.id, photo=photo)

    @staticmethod
    @__dp.message_handler(Text, state=KnowledgeTestDialogForm.people_test_3)
    async def process_test_knowledge_people_finish(message: types.Message, state: FSMContext):
        await OnboardBot.validate_answer(message, state)

        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)

    """
    Блок задать вопрос
    """
    @staticmethod
    @__dp.message_handler(Text(equals=MainKeyboard.buttons["btn_question"], ignore_case=True),
                          state=MainDialogForm.main)
    async def process_question(message: types.Message, state: FSMContext):
        await message.answer("Напишите свой вопрос", reply_markup=types.ReplyKeyboardRemove())
        await state.finish()
        await QuestionDialog.question.set()

    @staticmethod
    @__dp.message_handler(Text, state=QuestionDialog.question)
    async def process_question_message(message: types.Message, state: FSMContext):
        QUERY(OnboardBot.__connection,
              query=f"""UPDATE public."Employee" SET question = '{message.text}' WHERE id_chat = '{message.chat.id}' """)
        await state.finish()
        await MainDialogForm.main.set()
        await message.answer("Что хотите узнать?", reply_markup=MainKeyboard.main_kb)