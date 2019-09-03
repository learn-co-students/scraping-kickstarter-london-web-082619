require 'Nokogiri'

def create_project_hash
  html = File.read("fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html)

  projects = {}

  kickstarter.css(".project-card").each() do | project |
    title = project.css("h2").text()
    projects[title.to_sym()] = {
      image_link: project.css("img").attribute("src").value(),
      description: project.css("p").text,
      location: project.css(".location-name").text,
      percent_funded: project.css(".first_funded strong").text.gsub("%", "").to_i
    }
  end

  projects
end