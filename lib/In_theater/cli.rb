class In_theater::CLI
  def call
    start
  end

  def list(array)

    puts ""
    puts "************* Near by Theatres *************"
    puts ""
    array.each.with_index(1) do |movie, i|
      puts "#{i}. #{movie.name}"
    end
    puts ""

  end

  def print_movie(movie, input)
    puts ""
    puts "-------------- #{movie.name} --------------"

    puts ""
    In_theater::Movie.movies[input-1].each.with_index(1) do |movie, i|
      puts "#{i}. #{movie.name}"

    end

  end

  def start
    list(In_theater::Movie.all)
    input = nil
    while input != "exit"
      puts ""
      puts "What movie would you more information on, by name or number?"
      puts ""
      puts "Enter list to see the movies again."
      puts "Enter exit to end the program."
      puts ""
      input = gets.strip
      if input == "list"
        start
      elsif input == "exit"
        puts "Thanks for visiting us!"
        abort

      elsif input.to_i == 0
        if movie = In_theater::Movie.find_by_name(input, In_theater::Movie.all)
          print_movie(movie[0], movie[1])

            inputs2 = nil
            while inputs2 != "back"
              puts ""
              puts "What movie would you more information on, by name or number?"
              puts ""
              puts "Enter list to see the movies again."
              puts "Enter back to see the theater list again."
              puts ""

              inputs2 = gets.strip
              if inputs2 == "list"
                  list(In_theater::Movie.movies[movie[1]-1])

              elsif inputs2 == "back"
                break


              elsif inputs2.to_i == 0
                if movie = In_theater::Movie.find_by_name(inputs2, In_theater::Movie.movies[movie[1]])
                  In_theater::Movie.summary(movie[0])
                end

              elsif inputs2.to_i > 0
                if movie = In_theater::Movie.find(movie[1], In_theater::Movie.movies)
                  In_theater::Movie.summary(movie[inputs2.to_i-1])

                end

              end

            end
        end

      #end
      elsif input.to_i > 0
        if movie = In_theater::Movie.find(input.to_i, In_theater::Movie.all)
          print_movie(movie, input.to_i)
          inputs2 = nil
          while inputs2 != "back"
            puts ""
            puts "What movie would you more information on, by name or number?"
            puts ""
            puts "Enter list to see the movies again."
            puts "Enter back to see the theater list again."
            puts ""

            inputs2 = gets.strip

            if inputs2 == "list"
                list(In_theater::Movie.movies[input.to_i-1])

            elsif inputs2 == "back"
              break

            elsif inputs2.to_i == 0
              if movie = In_theater::Movie.find_by_name(inputs2, In_theater::Movie.movies[input.to_i])
                In_theater::Movie.summary(movie[0])

              end

            elsif inputs2.to_i > 0
              if movie = In_theater::Movie.find(input.to_i, In_theater::Movie.movies)
                In_theater::Movie.summary(movie[inputs2.to_i-1])

              end
            end
          end
        end
      end
    end
    puts "Thanks for visting us!!!"
  end
end
