import csv
import random

CITIES = ["Москва", "Санкт-Петербург", "Казань", "Екатеринбург", "Новосибирск", "Челябинск", "Ростов-на-Дону", "Воронеж", "Краснодар", "Нижний Новгород"]

def random_club_name():
    return random.choice(["Фитнес Клуб", "Спорт Лайф", "Энерджи", "Тонус", "Атлетик", "BodyFit", "PowerZone", "ProGym", "Flexx", "Iron Club"]) + " " + str(random.randint(1, 99))

with open("./init_data/clubs.csv", "w", newline="", encoding="utf-8") as f:
    writer = csv.writer(f)
    for i in range(1, 51):
        name = random_club_name()
        city = random.choice(CITIES)
        address = f"ул. {random.choice(['Ленина', 'Гагарина', 'Победы', 'Мира'])}, д. {random.randint(1, 100)}"
        location = f"{city}, {address}"
        members = random.randint(100, 2000)
        writer.writerow([i, name, location, members])
