#/bin/bash

#########Funciones#########

# Salir con ctrl_c
ctrl_c(){
  exit 1
  echo -e "\n[+]Saliendo...\n "
}

trap ctrl_c INT

#agruegar usuarios
adduser(){
  echo "\n[+] Escriba el nombre de usuario el cual quiere agregar: \n"
  read -r username
  $(useradd -s /bin/bash $username)
  echo "\n[+] Escriba la contrasena del nuevo usuario.\n\n"
  $(passwd $username)
}

# eliminar usuarios
deleteuser(){
  echo "\n[+] Escriba el nombre del usuario el cual quiere borrar\n"
  read -r username
  if grep -q "$username" /etc/passwd; then
    $(userdel $username)
  else
    echo "\n[!] El usuario $username no existe!\n"
  fi
}

#listar usuarios
listusers(){
  echo "\n[+] Lista de usuarios del sistema:\n"
  cut -d: -f1 /etc/passwd
}


#########Options#########
menu(){
    echo  "\n[+]Seleccione una opcion:\n"
    echo  "[+] 1. Crear un usuario \n"
    echo  "[+] 2. Eliminar un usuario\n"
    echo  "[+] 3. Listar los usuarios\n"
    echo  "[+] q. Salir\n"
    read -r option
    
    case "$option" in
      1) adduser ;;
      2) deleteuser ;;
      3) listusers ;;
      q) ctrl_c ;;
      *) echo "[!] No existe esa funcion";;
    esac
}

if [ "$(id -u)" -ne 0 ]; then
    echo "Este script debe ejecutarse como root."
    exit 1
fi
menu

