import random
from datetime import datetime, timedelta

# sequence
id = 1

# common male names
male_names = [
    "Aaron", "Abraham", "Adam", "Adrian", "Alan", "Albert", "Andrew",
    "Anthony", "Antonio", "Austin", "Benjamin", "Brandon", "Brian", "Caleb",
    "Cameron", "Carlos", "Chad", "Charles", "Christopher", "Cody", "Cole",
    "Daniel", "David", "Dennis", "Derek", "Diego", "Douglas", "Dustin", "Dylan",
    "Edward", "Eric", "Ethan", "Ezekiel", "Felipe", "Gabriel", "George", "Gregory",
    "Harold", "Henry", "Isaac", "Isaiah", "Jack", "Jacob", "Javier", "Jayden",
    "Jesse", "Joan", "John", "Jonathan", "Jordan", "Joseph", "Joshua", "Juan",
    "Julian", "Justin", "Keith", "Kevin", "Kyle", "Leonardo", "Lawrence", "Lucas",
    "Luke", "Miguel", "Nathan", "Nathaniel", "Nicholas", "Noah", "Oliver", "Owen",
    "Patrick", "Paul", "Philip", "Richard", "Robert", "Ronald", "Roy", "Ryan",
    "Samuel", "Sebastian", "Scott", "Sean", "Sebastian", "Shannon", "Stephen",
    "Theodore", "Thomas", "Timothy", "Travis", "Trevor", "Tyler", "Vincent",
    "Walter", "Wesley", "William", "Wyatt", "Xavier", "Zachary"
]

# common female names
female_names = [
    "Abigail", "Agnes", "Aisha", "Alana", "Alexandra", "Alexis", "Alice",
    "Alicia", "Allison", "Amanda", "Amelia", "Angela", "Ashley", "Audrey",
    "Ava", "Bethany", "Brenda", "Bridget", "Brittany", "Carla", "Caroline",
    "Catherine", "Cecilia", "Charlene", "Charlotte", "Cheryl", "Claire", "Claudia",
    "Courtney", "Danielle", "Deborah", "Diana", "Dorothy", "Evelyn", "Faith",
    "Fiona", "Gabriella", "Hannah", "Hayley", "Heather", "Helena", "Isabella",
    "Jacqueline", "Jade", "Jane", "Janet", "Jasmine", "Jennifer", "Jessica",
    "Jillian", "Joan", "Julia", "Karen", "Katherine", "Kayla", "Kelly", "Kimberly",
    "Kristen", "Laura", "Lauren", "Leah", "Leslie", "Lillian", "Lily", "Linda",
    "Lisa", "Lori", "Louise", "Lucia", "Lucy", "Lydia", "Madison", "Margaret",
    "Maria", "Martha", "Maya", "Meghan", "Michelle", "Molly", "Monica", "Nancy",
    "Natalie", "Nicole", "Olivia", "Pamela", "Patricia", "Penelope", "Peyton",
    "Phoebe", "Rachel", "Reagan", "Rebecca", "Rose", "Ruby", "Samantha", "Sandra",
    "Sarah", "Sharon", "Sheila", "Shirley", "Sophia", "Stephanie", "Susan", "Sydney",
    "Taylor", "Teresa", "Tiffany", "Victoria", "Vivian", "Zoe", "Mia", "Luna"
]

# common last names
last_names = [
    "Smith", "Johnson", "Williams", "Brown", "Jones",
    "Garcia", "Miller", "Davis", "Anderson", "Wilson",
    "Moore", "Taylor", "Thomas", "Evans", "Martinez",
    "Hernandez", "Robinson", "Lewis", "Clark", "Rodriguez",
    "Walker", "Hall", "Allen", "Young", "King",
    "Wright", "Lopez", "Scott", "Green", "Nguyen",
    "Walker", "Phillips", "Carter", "Campbell", "Mitchell",
    "Roberts", "Garcia", "Ramirez", "Cruz", "Lewis",
    "Rogers", "Moore", "Sanchez", "Lee", "Johnson",
    "Nelson", "Williams", "Brown", "Garcia", "Jones",
    "Miller", "Davis", "Clark", "Rodriguez", "Wilson",
    "Moore", "Taylor", "Thomas", "Allen", "Hernandez",
    "Hall", "Wright", "Lopez", "Walker", "Scott",
    "Robinson", "Hernandez", "Nguyen", "Campbell", "Mitchell",
    "Rogers", "Moore", "Sanchez", "Young", "Allen",
    "Nelson", "Phillips", "Roy", "Carter", "Adams",
    "Diaz", "Ramirez", "Cruz", "Hernandez", "Garcia",
    "Kim", "Nelson", "Thomas", "Lee", "Harris",
    "Watson", "Moore", "Garcia", "Allen", "Anderson",
    "Wright", "Lopez", "Hernandez", "Clark", "Rogers",
    "Lewis", "Robinson", "Walker", "Scott", "Mitchell",
    "Rodriguez", "Hernandez", "Johnson", "Young", "Allen",
    "Thompson", "Garcia", "Moore", "Hernandez", "Davis",
    "Nguyen", "Lopez", "Wilson", "Rodriguez", "Clark",
    "Lee", "Hernandez", "Robinson", "Walker", "Campbell",
    "Allen", "Wright", "Scott", "Lewis", "Miller",
    "Carter", "Rodriguez", "Hernandez", "Moore", "Garcia",
    "Young", "Allen", "Thomas", "Johnson", "Williams",
    "Davis", "Hernandez", "Lopez", "Miller", "Anderson",
    "Clark", "Nguyen", "Rogers", "Wilson", "Moore",
    "Walker", "Mitchell", "Garcia", "Hernandez", "Lewis",
    "Robinson", "Allen", "Campbell", "Wright", "Scott",
    "Rodriguez", "Hernandez", "Lopez", "Nelson", "Thomas",
    "Lee", "Harris", "Garcia", "Allen", "Moore"
]


def random_first_name():
    rnd_gender = random.randint(0, 1)
    if (rnd_gender == 0):
        return male_names[random.randint(0, 96)]
    return female_names[random.randint(0, 111)]


def random_last_name():
    return last_names[random.randint(0, 169)]


def random_father_name():
    return male_names[random.randint(0, 96)]


def random_mother_name():
    return female_names[random.randint(0, 111)]


def random_b_date(start_year=2005, end_year=2024):
    """Generates a random date between start_year and end_year."""
    start_date = datetime(start_year, 1, 1)
    end_date = datetime(end_year, 12, 31)
    random_date = start_date + timedelta(days=random.randint(0, (end_date - start_date).days))
    return random_date.strftime('%Y/%m/%d')


def random_phone():
    """Generates a phone number in the format 05[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]."""
    return f"05{random.randint(10000000, 99999999)}"


def random_class():
    return random.randint(1, 40)


def insert_statement():
    global id
    student_id = id
    id+=1
    first_name = random_first_name()
    last_name = random_last_name()
    birth_date = random_b_date()
    phone = random_phone()
    father = random_father_name()
    mother = random_mother_name()
    class_id = random_class()
    return f"""INSERT INTO HADASSAH.STUDENT(STUDENT_ID, FIRST_NAME, LAST_NAME, BIRTH_DATE, PHONE, FATHERNAME, MOTHERNAME, CLASS_ID) 
    VALUES({student_id}, '{first_name}', '{last_name}', TO_DATE('{birth_date}', 'yyyy/mm/dd'), {phone}, '{father}', '{mother}', {class_id});"""


if __name__ == "__main__":
    with open("insert_commands.txt", "w") as file:
        for i in range(700):
            insert_list = insert_statement()
            file.write(f"{insert_list} \n")