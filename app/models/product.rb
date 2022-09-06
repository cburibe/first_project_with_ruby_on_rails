class Product < ApplicationRecord

  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
# Esto hereda de una clase de activerecord que es una parte de rails llamado ORM lo que hace es mapear una tabla en sql
# codigo ruby.
# Una vez creado - ejecutar la migraciones.
# Al crear el modelo debe ser Mayus la primera letra y singular. Al crear el modelo se crean las migraciones