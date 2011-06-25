Fabricator(:event) do
  id { 1 }
  name { "Blabla" }
  description { "Blablablablabla" }
  starts_at { Time.now - 2.days }
  ends_at { Time.now + 2.days }
  location
  homepage { 'http://www.projectlodge.org' }
end
