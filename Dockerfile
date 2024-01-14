# Use uma imagem base do Python
FROM python:3.10.10

# Crie e configure o diretório de trabalho no contêiner
WORKDIR /app

# Copie o arquivo requirements.txt para o contêiner
COPY requirements.txt /app/

# Crie e ative um ambiente virtual
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

# Atualize o pip
RUN pip install --upgrade pip

# Instale as dependências do seu projeto
RUN pip install -r requirements.txt

# Copie o conteúdo do diretório do seu projeto para o contêiner
COPY . /app/

# Configure a variável de ambiente para o Django
ENV DJANGO_SETTINGS_MODULE=ProjetoDjango2.settings

# Execute o comando para coletar arquivos estáticos do Django
RUN python manage.py collectstatic --noinput

# Exponha a porta em que o aplicativo Django será executado
EXPOSE 8000

# Comando para iniciar o aplicativo Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
