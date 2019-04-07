Totalcards = []
Player1 = []
Computer_player = []
SUITS = ['Spades','Diamonds', 'Hearts', 'Clubs']
score = 0

def game_start 
  new_deck
  shuffle
  2.times do 
    deal_Computer_player
    dealPlayer
  end
  show_hands
end

def new_deck
  SUITS.each do |suit|
    (2..10).each do |num|
      Totalcards.push(num.to_s + " " + suit) 
    end
    ['J','Q','K','A'].each do |item|
      Totalcards.push(item + " "+ suit)
    end
  end
end

def shuffle 
  2000.times {Totalcards.insert(rand(Totalcards.length),Totalcards.pop)}
  Totalcards.shuffle
end

def dealPlayer
  Player1.unshift(Totalcards.shift)
end

def show_hands
  puts "Your hand: #{Player1}"
  puts "Computer hand visible: #{Computer_player[0]}" 
end

def computer_needs_deal?
  while get_score(Computer_player, true) < 17
    deal_Computer_player
    check_score(Computer_player)
  end
  #computer_needs_deal?
end

def deal_Computer_player
  Computer_player.unshift(Totalcards.shift)
end

def get_score(hand, comp= false )
  score = 0
  hand.each do |card|
    temp_card_score = (/^(\w+)/.match(card)[0])
    if temp_card_score == 'A'
      score += 11
    elsif temp_card_score == 'J'
      score += 10
    elsif temp_card_score == 'Q'
      score += 10
    elsif temp_card_score == 'K'
      score += 10
    else 
      score += temp_card_score.to_i
    end
  end
  if comp == false
    puts "Score for Player 1: " + score.to_s
  end
  score
end

def more_cards?
  puts "Do you want another card? (y/n)"
  wants_more = gets.chomp
  if wants_more == 'y'
    dealPlayer
    show_hands
    check_score(get_score(Player1))
  elsif wants_more == 'n'
    computer_needs_deal?
    final_score
  else
    puts 'That is not a valid response'
    more_cards?
  end
end

def check_score(score)
  if score == 21
    puts "You won! Nice job"
    20.times {print "#"}
  elsif score > 21
    puts "You lost! Have another go."
    20.times {print "#"}
  else
    more_cards?
  end
end

def final_score
  computer_score = get_score(Computer_player,true)
  player1_score = get_score(Player1)
  puts "Score for computer: " + computer_score.to_s
  if computer_score > player1_score
    puts "Computer won!"
  else
    puts "You won!"
  end
end

game_start
get_score(Player1)

more_cards?