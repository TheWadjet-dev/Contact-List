require 'sinatra'
require 'sinatra/reloader' if development?

# In-memory storage for contacts
class Contact
  attr_accessor :name, :email, :phone

  def initialize(name, email, phone)
    @name = name
    @email = email
    @phone = phone
  end
end

class Agenda
  def initialize
    @contacts = []
  end

  def all
    @contacts
  end

  def add(contact)
    @contacts << contact
  end

  def find(index)
    @contacts[index]
  end

  def update(index, name, email, phone)
    contact = @contacts[index]
    contact.name = name
    contact.email = email
    contact.phone = phone
  end

  def delete(index)
    @contacts.delete_at(index)
  end
end

agenda = Agenda.new

# Root route - show the list of contacts
get '/' do
  @contacts = agenda.all
  erb :index
end

# Route to show the form to add a new contact
get '/contacts/new' do
  erb :new
end

# Route to add a new contact
post '/contacts' do
  name = params[:name]
  email = params[:email]
  phone = params[:phone]
  contact = Contact.new(name, email, phone)
  agenda.add(contact)
  redirect '/'
end

# Route to show the form to edit an existing contact
get '/contacts/:index/edit' do
  @contact = agenda.find(params[:index].to_i)
  erb :edit
end

# Route to update an existing contact
put '/contacts/:index' do
  name = params[:name]
  email = params[:email]
  phone = params[:phone]
  agenda.update(params[:index].to_i, name, email, phone)
  redirect '/'
end

# Route to delete a contact
delete '/contacts/:index' do
  agenda.delete(params[:index].to_i)
  redirect '/'
end
