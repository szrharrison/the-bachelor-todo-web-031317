require 'pry'
def contestant_lookup( scraped_data, given_i, given_i_value = nil, requested_i = nil, season = nil )
  contestants = []
  result = []
  if given_i.include?( 'season' )
    season = given_i
  end
  scraped_data.each do |season_number, contestant_hashes|
    if season == season_number || season == nil
      contestant_hashes.each do |contestant_hash|
        if given_i == contestant_hash.key( given_i_value ) || given_i == season
          contestants << contestant_hash
        end
      end
    end
  end
  if contestants.empty?
    result = 'no match found'
  elsif requested_i != nil
    if contestants.length > 1
      contestants.each do |contestant|
        result << contestant[requested_i]
      end
    else
      result = contestants[0][requested_i]
    end
  else
    result = contestants
  end
  result
end

def get_first_name_of_season_winner(data, season)
  # code here
  contestant_name = contestant_lookup( data, 'status', 'Winner', 'name', season )
  contestant_name.split[0]
end

def get_contestant_name(data, occupation)
  # code here
  contestant_name = contestant_lookup( data, 'occupation', occupation, 'name' )
end

def count_contestants_by_hometown(data, hometown)
  # code here
  contestants = contestant_lookup( data, 'hometown', hometown )
  contestants.length
end

def get_occupation(data, hometown)
  # code here
  occupation = contestant_lookup( data, 'hometown', hometown, 'occupation' )
  result = occupation
  # Tests only expect the first person returned
  if occupation.is_a?( Array )
    result = occupation[0]
  end
  result
end

def get_average_age_for_season(data, season)
  # code here
  sum = 0
  contestants = contestant_lookup( data, season )
  contestants.each do |contestant|
    sum += contestant['age'].to_f
  end
  average = (sum / contestants.length).round

end
