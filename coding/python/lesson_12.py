import random


class Character:
    def __init__(self):
        self.name = None
        self.image = None
        self.strength = None
        self.agility = None
        self.life = None
        self.damage = None

    def character_generate_name(self):
        namelist = [
            "Ari",
            "Kai",
            "Ezra",
            "Amari",
            "Nova",
            "Milan",
            "Onyx",
            "Zion",
            "Layne",
            "Wren",
        ]
        index = random.randint(0, 9)
        self.name = namelist[index]
        print("NAME: " + self.name)

    def character_generate_image(self):
        index = random.randint(0, 9)
        self.image = index
        print(self.image)

    def character_generate_strength(self):
        index = random.randint(5, 10)
        self.strength = index
        print("STR: " + str(self.strength))

    def character_generate_agility(self):
        index = random.uniform(0.1, 1.0)
        self.agility = index
        print("AGI: " + str(self.agility))

    def character_generate_life(self):
        index = random.randint(50, 100)
        self.life = index
        print("LIFE: " + str(self.life))

    def character_damage(self):
        self.damage = self.strength * self.agility + random.uniform(0.1, 0.5)
        print(self.name + " did: " + str(self.damage) + " DAMAGE")


def do_fight():
    print("---------")
    print("--FIGHT--")
    print("---------")

    while (character_1.life > 0) and (character_2.life > 0):
        character_1.character_damage()
        character_2.life = character_2.life - character_1.damage
        character_2.character_damage()
        character_1.life = character_1.life - character_2.damage

        if character_1.life <= 0:
            print("---------")
            print(character_1.name + " is DEAD!")
            print("---------")
            break

        if character_2.life <= 0:
            print("---------")
            print(character_2.name + " is DEAD!")
            print("---------")
            break


character_1 = Character()
character_2 = Character()

character_1.character_generate_name()
character_1.character_generate_strength()
character_1.character_generate_agility()
character_1.character_generate_life()
print("---------")
character_2.character_generate_name()
character_2.character_generate_strength()
character_2.character_generate_agility()
character_2.character_generate_life()
do_fight()
