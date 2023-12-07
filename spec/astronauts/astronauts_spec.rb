# User Story 1 of 4

# As a visitor,
# When I visit the Astronauts index page ('/astronauts')
# I see a list of astronauts with the following info:
# - Name
# - Age
# - Job

# (e.g. "Name: Neil Armstrong, Age: 37, Job: Commander")
require "rails_helper"

RSpec.describe "Astronauts index", type: :feature do
  it "shows a list of astronauts with their attributes" do
    astronaut1 = Astronaut.create!(name: "Jim Swanson", age: 34, job: "Fly the Thing")
    astronaut2 = Astronaut.create!(name: "Blake Bilboa", age: 33, job: "Call the Shots")
    astronaut3 = Astronaut.create!(name: "Gerald Florentine", age: 36, job: "Poster Boy")

    visit "/astronauts"

    expect(current_path).to eq("/astronauts")
    expect(page).to have_content(astronaut1.name)
    expect(page).to have_content(astronaut2.name)
    expect(page).to have_content(astronaut3.name)
  end

# User Story 2 of 4

# As a visitor,
# When I visit the Astronauts index page ('/astronauts')
# I see the average age of all astronauts.

# (e.g. "Average Age: 34")

  it "shows the average age of the astronauts" do
    astronaut1 = Astronaut.create!(name: "Jim Swanson", age: 34, job: "Fly the Thing")
    astronaut2 = Astronaut.create!(name: "Blake Bilboa", age: 33, job: "Call the Shots")
    astronaut3 = Astronaut.create!(name: "Gerald Florentine", age: 36, job: "Poster Boy")

    visit "/astronauts"

    expect(current_path).to eq("/astronauts")
    expect(page).to have_content("Average Age: 34.33")
    expect(page).to have_content(astronaut1.name)
  end

# User Story 3 of 4

# As a visitor,
# When I visit the Astronauts index page ('/astronauts')
# I see a list of the space missions' in alphabetical order for each astronaut.

# (e.g "Apollo 13"
#      "Capricorn 4"
#      "Gemini 7")

it "shows each astronaut's mission listed alphabetically" do
  astronaut1 = Astronaut.create!(name: "Jim Swanson", age: 34, job: "Fly the Thing")
  astronaut2 = Astronaut.create!(name: "Blake Bilboa", age: 33, job: "Call the Shots")
  astronaut3 = Astronaut.create!(name: "Gerald Florentine", age: 36, job: "Poster Boy")
  astronaut3.missions.create!(title: "Planet X", time_in_space: 35)

  missions_list = ["Mars", "Luna", "ISS"]
  missions_list.each do |mission_title|
    Mission.create!(title: mission_title, time_in_space: 10)
  end

  astronaut1.missions << Mission.where(title: missions_list)
  astronaut2.missions << Mission.where(title: missions_list)
  astronaut3.missions << Mission.where(title: missions_list)

  visit "/astronauts"

  expect(current_path).to eq("/astronauts")
  # Ensure missions are listed alphabetically
  expect(page.body.index("Luna")).to be < page.body.index("Planet X")
  expect(page.body.index("ISS")).to be < page.body.index("Planet X")
end

# User Story 4 of 4

# As a visitor,
# When I visit the Astronauts index page ('/astronauts')
# I see the total time in space for each astronaut.
# (e.g. "Name: Neil Armstrong, Age: 37, Job: Commander, Total Time in Space: 760 days")

  it "shows the total time in space for each astronaut" do
    astronaut1 = Astronaut.create!(name: "Jim Swanson", age: 34, job: "Fly the Thing")
    astronaut2 = Astronaut.create!(name: "Blake Bilboa", age: 33, job: "Call the Shots")
    astronaut3 = Astronaut.create!(name: "Gerald Florentine", age: 36, job: "Poster Boy")
    astronaut3.missions.create!(title: "Planet X", time_in_space: 3335)
    astronaut1.missions.create!(title: "Venus", time_in_space: 364)
    astronaut2.missions.create!(title: "Saturn", time_in_space: 957)

    missions_list = ["Mars", "Luna", "ISS"]
    missions_list.each do |mission_title|
      Mission.create!(title: mission_title, time_in_space: 45)
    end

    astronaut1.missions << Mission.where(title: missions_list)
    astronaut2.missions << Mission.where(title: missions_list)
    astronaut3.missions << Mission.where(title: missions_list)

    visit "/astronauts"

    expect(current_path).to eq("/astronauts")
    expect(page).to have_content(499)
    expect(page).to have_content(1092)
    expect(page).to have_content(3470)
  end
end
