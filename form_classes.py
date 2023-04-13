from aiogram.dispatcher.filters.state import StatesGroup, State


class StartDialogForm(StatesGroup):
    employee: State = State()
    full_name: State = State()


class MainDialogForm(StatesGroup):
    main: State = State()


class EmployeesDialogForm(StatesGroup):
    employees: State = State()
    detail: State = State()


class ProductsDialogForm(StatesGroup):
    products: State = State()


class KnowledgeTestDialogForm(StatesGroup):
    knowledge_test: State = State()

    people_test_1: State = State()
    people_test_2: State = State()
    people_test_3: State = State()


class QuestionDialog(StatesGroup):
    question: State = State()
