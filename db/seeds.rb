require 'open-uri'
require 'pry'

Game.destroy_all

Game.reset_pk_sequence

def seed_games
  html = open('https://en.wikipedia.org/wiki/List_of_video_games_considered_the_best')
  doc = Nokogiri::HTML(html)
  table_rows = doc.search('.wikitable').search('tr').drop(1).map {|row| row.text.gsub(/\n\n/, "\n").split("\n")}.slice(0, 176).map {|row| row.drop(1) if row[0] == ''}
  table_rows = table_rows.map! {|row| row[0].to_i == 0 ? row.unshift("") : row}
  i = 0
  while i < table_rows.length
    if table_rows[i][0] == ''
      table_rows[i][0] = table_rows[i-1][0]
    end
    i += 1
  end
  table_rows.each do |game|
    Game.create(name: game[1], genre: game[2], release_year: game[0].to_i, publisher: game[3], platform: game[4])
  end
end
seed_games

def add_pic
  Game.all.each do |game|
    url_name = game.name.split(' ').join('_')
    if url_name == 'Asteroids' || url_name == 'Joust' || url_name == 'Elite' || url_name == 'The_Legend_of_Zelda' || url_name == 'Contra' || url_name == 'Another_World' || url_name == 'Civilization' || url_name == 'Lemmings' || url_name == 'Quake' || url_name == 'Gran_Turismo' || url_name == 'Half-Life' || url_name == 'StarCraft' || url_name == 'Counter-Strike' || url_name == 'Deus_Ex' || url_name == 'The_Sims' || url_name == 'Guitar_Hero' || url_name == 'Gears_of_War' || url_name == 'Portal' || url_name == 'Braid' || url_name == 'Dead_Space' || url_name == 'Limbo' || url_name == 'Inside'
      url_name += '_(video_game)'
    elsif url_name == 'Defender'
      url_name = 'Defender_(1981_video_game)'
    elsif url_name == 'Gauntlet'
      url_name = 'Gauntlet_(1985_video_game)'
    elsif url_name == 'SimCity'
      url_name = 'SimCity_(1989_video_game)'
    elsif url_name == 'Sonic_the_Hedgehog'
      url_name = 'Sonic_the_Hedgehog_(1991_video_game)'
    elsif url_name == 'Mortal_Kombat'
      url_name = 'Mortal_Kombat_(1992_video_game)'
    elsif url_name == 'Doom'
      url_name = 'Doom_(1993_video_game)'
    elsif url_name == 'Resident_Evil'
      url_name = 'Resident_Evil_(1996_video_game)'
    elsif url_name == 'Tomb_Raider'
      url_name = 'Tomb_Raider_(1996_video_game)'
    elsif url_name == 'GoldenEye_007'
      url_name = 'GoldenEye_007_(1997_video_game)'
    elsif url_name == 'God_of_War'
      url_name = 'God_of_War_(2005_video_game)'
    elsif url_name == 'Journey'
      url_name = 'Journey_(2012_video_game)'
    elsif url_name == 'The_Walking_Dead'
      url_name = 'The_Walking_Dead_(video_game_series)'
    elsif url_name == 'Pokémon_Red_and_Blue'
      url_name = 'Pokemon_Red_and_Blue'
    elsif url_name == 'Ōkami'
      url_name = 'Okami'
    elsif url_name == "NBA Jam"
      game.update(image: 'https://i.ytimg.com/vi/5mf98dAnQ88/hqdefault.jpg')
    end
    html = open("https://en.wikipedia.org/wiki/#{url_name}")
    doc = Nokogiri::HTML(html)
    if doc.search('.infobox').search('.image')[0] != nil
      image_page = doc.search('.infobox').search('.image')[0].attributes['href'].value
      image_html = open("https://en.wikipedia.org/#{image_page}")
      image_doc = Nokogiri::HTML(image_html)
      image_link = image_doc.search('.fullImageLink').search('img')[0].attributes['src'].value
      game.update(image: "https:#{image_link}")
    end
  end
end
add_pic

# nba_jam = Game.find_by(name: "NBA Jam")
# nba_jam.update(image: '/app/assets/images/nba_jams.jpeg')
