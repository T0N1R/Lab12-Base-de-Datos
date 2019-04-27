import psycopg2

#Conexion a database
conn = psycopg2.connect("dbname=Lab12 user=postgres password=060f3d4eae")

#cursor para hacer operaciones en la database
cur = conn.cursor()

def menu():
    print("Ingrese la accion que se quiere realizar: " + "\n" +
    "1. Consulte al usuario por un precio y devuelva las características de la PC con el precio más cercano al solicitado." + "\n" + 
    "2. Consulte al usuario por valores mínimos de speed, ram y hd.  Despliegue todas las laptops que cumplan estas características.  La información desplegada debe de contener también el maker." + "\n" +
    "3. Consulte al usuario por un presupuesto máximo para gasto de una PC + Printer y una speed mínima para la PC. Con esta información debe desplegar las combinaciones de PC y Printer que cumplen con estos criterios. " + "\n" +
    "4. " + "\n" +
    "5. Dado un precio ingresado por el usuario, devuelva la cantidad de PCs, cantidad de Laptops y cantidad de Printersque que son vendidas a un precio superior al ingresado." + "\n" +
    "0. Salir" + "\n"
    )

respuesta = "100"
while respuesta != "0":
    menu()
    respuesta = input()

    if (respuesta == "1"):
        valor = input("Ingrese la precio: ")

        query = "SELECT cercano({});".format(valor)

        cur.execute(query)
        conn.commit()
        print("*********************************************")
        print(cur.fetchall())        
        print("*********************************************")


    if (respuesta == "2"):
        speed = input("Ingrese la velocidad: ")
        ram = input("Ingrese el ram: ")
        hd = input("Ingrese el hd: ")

        query = "SELECT minimo({},{},{});".format(speed, ram, hd)
        
        cur.execute(query)
        conn.commit()
        print("*********************************************")
        print(cur.fetchall())        
        print("*********************************************")


    if (respuesta == "3"):
        precio = input("Ingrese el presupuesto: ")
        vel_minima = input("Ingrese la velocidad minima: ")

        query = "SELECT pcANDprinter({},{});".format(precio, vel_minima)

        cur.execute(query)
        conn.commit()
        print("*********************************************")
        print(cur.fetchall())        
        print("*********************************************")

    if (respuesta == "4"):
        print(":V")

    if (respuesta == "5"):
        precio = input("Ingrese el precio minimo: ")

        query = "SELECT productosBudget({});".format(precio)

        cur.execute(query)
        conn.commit()

        print("*********************************************")
        print(cur.fetchall())        
        print("*********************************************")
        
        

cur.close()
conn.close()
