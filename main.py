import subprocess

def runsh():
        try:
            # termux.sh scriptini çalıştır
            result = subprocess.run(['bash', 'termux.sh'], check=True, text=True, capture_output=True)
            print("Output:")
            print(result.stdout)
        except subprocess.CalledProcessError as e:
            print("Error:")
            print(e.stderr)

while True:
    print("Welcome to builder")
    print("1. Termux\n2. Windows-WIP\n3. Exit")

    select = input("Select: ")

    if select == '1':
        print("Termux is choosen")
        runsh()
    elif select == '2':
        print("Working in progress")
        # WIP
    elif select == '3':
        print("exit.")
        break  # proqramdan cixilir
    else:
        print("Geçersiz seçim!")
