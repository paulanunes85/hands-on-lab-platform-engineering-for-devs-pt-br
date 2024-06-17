# Provisionnement des Dev Boxes
Ce projet contient un script shell pour provisionner des Dev Boxes pour une liste d'utilisateurs.

# Fichiers
provision_dev_boxes.sh : C'est le script principal qui crée des Dev Boxes pour chaque utilisateur dans le fichier users.csv.
users.csv : Ce fichier contient une liste d'adresses e-mail d'utilisateurs pour lesquels les Dev Boxes seront créées.
# Comment utiliser
 - Assurez-vous que vous avez Azure CLI installé et configuré sur votre machine.
 - Mettez à jour le fichier users.csv avec les adresses e-mail des utilisateurs pour lesquels vous souhaitez créer des Dev Boxes ainsi que leur mot de passe
 - Exécutez le script provision_dev_boxes.sh avec la commande suivante :
Le script lira le fichier users.csv, se connectera sur le portail Azure de chaque utilisateur, générera un nom unique pour la Dev Box en utilisant uuidgen, puis créera la Dev Box dans le centre de développement spécifié.

# Remarques
Le script utilise le nom de pool Standard-Pool, le nom de projet frontend-project et le centre de développement web-dev-center par défaut. Si vous souhaitez utiliser des valeurs différentes, vous devrez modifier le script en conséquence.
Le script ne bloque pas et ne vérifie pas si la création de la Dev Box a réussi. Il lance simplement la commande de création et passe à l'utilisateur suivant.