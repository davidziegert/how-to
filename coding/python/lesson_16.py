import tkinter
import tkinter.messagebox
from tkinter import *
from tkinter import ttk


def dosomething1():
    tkinter.messagebox.showinfo("Messagebox-Title1", "Hi I'm your message")
    pass


root = tkinter.Tk()
root.title = "MyTitle"
root.geometry("800x600")

mainmenu = Menu(root)
mainmenu.add_command(label="Do", command=dosomething1)
mainmenu.add_command(label="Exit", command=root.destroy)
root.config(menu=mainmenu)

button1 = tkinter.Button(root, text="click me", command=dosomething1)
button1.pack()

chkvar1 = IntVar()
chkbutton1 = Checkbutton(root, variable=chkvar1)
chkbutton1.pack()

radiovar1 = IntVar()
radiobutton1 = Radiobutton(root, variable=radiovar1)
radiobutton1.pack()

labelvar1 = StringVar()
labelvar1.set("Hello World 1")
label1 = Label(root, textvariable=labelvar1)
label1.pack()
label2 = Label(root, text="Hello World 2")
label2.pack()

entryvar1 = StringVar()
entry1 = tkinter.Entry(root, textvariable=entryvar1)
entry1.pack()

list1 = ["Option1", "Option2", "Option3"]
combobox1 = ttk.Combobox(root, values=list1)
combobox1.set("Pick an Option")
combobox1.pack()

listbox1 = Listbox(root)
listbox1.insert(1, "Bread")
listbox1.insert(2, "Milk")
listbox1.insert(3, "Meat")
listbox1.pack()

# WIDGETS
# Frame: Outlines the frame for your Tkinter window with a fixed size. Just like the human skeleton, a Tkinter window requires a frame to support it and give it structure.
# Label: A Tkinter widget used to display simple lines of text on a GUI. Also very versatile, and can even be used to display images.
# Buttons: The Python Tkinter Button is a standard Tkinter widget. A button is used as a way for the user to interact with the User interface. Once the button is clicked, an action is triggered by the program.
# Entry: A standard Tkinter widget used to take input from the user through the user interface. A simple box is provided where the user can input text.
# Check Button: A check button is a Tkinter GUI widget that presents to the user a set of predefined options. The user may select more than one option.
# Radio Button: A radio button is a Tkinter GUI widget that allows the user to choose only one of a predefined set of mutually exclusive options.
# Menu: The Tkinter Menu widget is used to create various types of menus  in the GUI such as top-level menus, which are displayed right under the title bar of the parent window.
# ComboBox: A special extension of Tkinter, the ttk module brings forward this widget. A combobox presents a drop down list of options and displays them one at a time. Has a more modern approach than other similar widgets.
# List Box: Another Tkinter widget that is used to display a list of options for the user to select. Displays all of the options in one go. Furthermore, all options are in text format.
# Menu Button: A combination of both the button and menu widget, this button widget displays a drop down menu with a list of options once clicked. This widget is unique because it’s able to incorporate aspects of both check buttons and radio buttons into it.
# Canvas: One of the more advanced Tkinter widgets. As the name suggests, it’s used to draw graphs and plots on. You can even display images on a Canvas. It’s like a drawing board on which you can paint or draw anything.
# Scale: The Tkinter Scale widget is used to implement a graphical slider to the User interface giving the user the option of picking through a range of values. The Maximum and minimum values on the Scale can be set the programmer.
# Scrollbar: A useful widget in GUI’s, which allows you to scroll in a Tkinter window or enable scroll for certain widgets. Typically used when you’re limited in space for your Tkinter window, but want more space for the widget (e.g Canvas).
# Toplevel: A widget in Tkinter that allows for the easy spawning of new Tkinter Windows. Toplevel is a better alternative to spawning extra tkinter windows by using tk().

root.mainloop()
