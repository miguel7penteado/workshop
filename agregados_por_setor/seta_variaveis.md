

```cmd
echo "Obtendo o PIP for windows..."
cmd /c curl https://bootstrap.pypa.io/get-pip.py --progress-bar -o %tmp%\\get-pip.py

"Instalando o PIP for windows... "
cmd /c python  %tmp%\\get-pip.py 

echo "Fazendo o python instalar os modulos descompactadores com PIP... "
cmd /c python -m pip install -U --user pyunpack patool entrypoint2
```

```bash
echo  "$MINHA_SENHA|sudo -S apt-get install -y python-pip"
echo  "$MINHA_SENHA|sudo -S apt-get install -y python3-pip"
echo  "$MINHA_SENHA|sudo -S apt-get install -y unzip unrar p7zip-full"
echo  "$MINHA_SENHA|sudo -S pip install -U --user pyunpack patool entrypoint2"
```
