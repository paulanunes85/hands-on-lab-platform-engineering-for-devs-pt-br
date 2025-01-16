# Provisionamento de Ambiente

## Implantando os recursos do DevCenter

Um script ([deploy.sh](deploy.sh)) está disponível para implantar:
- Um devcenter com pools, definições, catálogo, projetos, etc.

## Criar devbox em nome dos usuários

Este projeto contém um script shell para provisionar Dev Boxes para uma lista de usuários.

### Arquivos

[provision_dev_boxes.sh](provision_dev_boxes.sh): Este é o script principal que cria Dev Boxes para cada usuário no arquivo users.csv.
users.csv: Este arquivo contém uma lista de endereços de e-mail dos usuários para os quais as Dev Boxes serão criadas.

### Como usar

- Certifique-se de que você tenha o Azure CLI instalado e configurado em sua máquina.
- Atualize o arquivo users.csv com os endereços de e-mail dos usuários para os quais você deseja criar Dev Boxes, bem como suas senhas.
- Execute o script provision_dev_boxes.sh com o seguinte comando:
O script lerá o arquivo users.csv, fará login no portal do Azure para cada usuário, gerará um nome único para a Dev Box usando uuidgen e, em seguida, criará a Dev Box no centro de desenvolvimento especificado.

> **Nota**: O script não bloqueia e não verifica se a criação da Dev Box foi bem-sucedida. Ele simplesmente lança o comando de criação e passa para o próximo usuário.