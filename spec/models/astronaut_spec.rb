require 'rails_helper'

describe Astronaut, type: :model do
  describe 'Validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :age }
    it { should validate_presence_of :job }
  end

  describe 'Relationships' do
    it { should have_many :astronaut_missions}
    it { should have_many :missions}
  end

  describe "methods" do
    it "has an #average_age class method to find the average age of the astronauts" do
      astronaut1 = Astronaut.create!(name: "Jim Swanson", age: 34, job: "Fly the Thing")
      astronaut2 = Astronaut.create!(name: "Blake Bilboa", age: 33, job: "Call the Shots")
      astronaut3 = Astronaut.create!(name: "Gerald Florentine", age: 36, job: "Poster Boy")

      expect(Astronaut.average_age.round(2)).to eq(34.33)
    end

    it "has an instance method called #sort_alpha that sorts an astronaut's missions alphabetically" do
      astronaut1 = Astronaut.create!(name: "Jim Swanson", age: 34, job: "Fly the Thing")
      mission1 = astronaut1.missions.create!(title: "Mars", time_in_space: 567)
      mission2 = astronaut1.missions.create!(title: "Europa", time_in_space: 765)
      mission3 = astronaut1.missions.create!(title: "Venus", time_in_space: 654)

      expect(astronaut1.sort_alpha).to eq([mission2, mission1, mission3])
    end

    it "has a #total_time_in_space instance method for summing an astronauts mission times" do
      astronaut1 = Astronaut.create!(name: "Jim Swanson", age: 34, job: "Fly the Thing")
      mission1 = astronaut1.missions.create!(title: "Mars", time_in_space: 567)
      mission2 = astronaut1.missions.create!(title: "Europa", time_in_space: 765)
      mission3 = astronaut1.missions.create!(title: "Venus", time_in_space: 654)

      expect(astronaut1.total_time_in_space).to eq(1986)
    end
  end
end
