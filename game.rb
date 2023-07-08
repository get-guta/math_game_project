class Game
  def initialize
    @players = []
    @players << Player.new("Player 1")
    @players << Player.new("Player 2")
    @current_player = @players.first
  end

  def play
    while game_ongoing?
      generate_question
      print_scores
      check_answer(gets.chomp.to_i)
      switch_turns
    end

    puts "----- Game Over -----"
    puts "#{winner.name} wins with a score of #{winner.lives}/3"
  end

  private

  def game_ongoing?
    @players.any?(&:alive?)
  end

  def generate_question
    @number1 = rand(1..20)
    @number2 = rand(1..20)
    @answer = @number1 + @number2
    puts "----- New Turn -----"
    puts "#{current_player.name}, what is the answer to #{@number1} + #{@number2}?"
  end

  def print_scores
    puts "----- Scores -----"
    @players.each { |player| puts "#{player.name}: #{player.lives}/3" }
  end

  def check_answer(player_answer)
    if player_answer == @answer
      puts "Correct answer, #{@current_player.name}!"
    else
      puts "Wrong answer! #{@current_player.name} loses a life."
      @current_player.lose_life
    end
  end

  def switch_turns
    @current_player = @players.rotate!.first
  end

  def winner
    @players.find(&:alive?)
  end

  def current_player
    @current_player
  end
end
