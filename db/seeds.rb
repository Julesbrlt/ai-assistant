# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
user = User.create(email: "juchapl@g.com", password: "tototo")

Company.destroy_all

Company.create!([{
  user: user,
  name: "GreenTech Solutions",
  activity: "Énergies renouvelables",
  description: "Startup spécialisée dans les solutions solaires et éoliennes pour les particuliers et les entreprises.",
  objectives: "Promouvoir l’accès simple et abordable à une énergie propre et réduire l’empreinte carbone.",
  location: "Lyon",
  size: "11-50"
},
{
  user: user,
  name: "FoodLab Innov",
  activity: "Agroalimentaire",
  description: "Laboratoire de recherche culinaire développant des produits alimentaires sains et durables.",
  objectives: "Transformer l’industrie alimentaire avec des alternatives durables et meilleures pour la santé.",
  location: "Paris",
  size: "51-200"
},
{
  user: user,
  name: "SkyNet Logistics",
  activity: "Logistique et transport",
  description: "Entreprise de transport moderne, utilisant une flotte électrique pour livrer rapidement partout.",
  objectives: "Réduire l’impact écologique de la logistique tout en garantissant une chaîne efficace et fiable.",
  location: "Marseille",
  size: "201-500"
},
{
  user: user,
  name: "MedicaPlus",
  activity: "Santé et biotechnologie",
  description: "Société qui développe des dispositifs médicaux connectés pour améliorer le suivi des soins.",
  objectives: "Amener la santé connectée au service des patients en offrant innovation et efficacité médicale.",
  location: "Toulouse",
  size: "51-200"
},
{
  user: user,
  name: "PixelForge Studio",
  activity: "Jeux vidéo et multimédia",
  description: "Studio créatif indépendant qui produit des jeux immersifs et des expériences en réalité augmentée.",
  objectives: "Concevoir des expériences ludiques inclusives et originales, accessibles au plus grand nombre.",
  location: "Bordeaux",
  size: "1-10"
}])
