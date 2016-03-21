namespace :scheduler do
  desc "Postavlja/Miče popuste ovisno o start_date i end_date artikla"

  task set_discount: :environment do
    puts "Ušao u set discount!"

    @articles = Article.where(for_sale: true)

    @articles.each do |art|
      if art.on_discount != nil && art.on_discount == false #ako nije na popustu provjeri da li mora biti na popustu

        if art.start_date != nil && art.start_date.to_datetime <= DateTime.now && art.end_date.to_datetime >= DateTime.now
          puts "Postavljam popust na #{art.title}!!"
          art.update(on_discount: true)
        end

      else #provjeri ako je na popustu da li treba artikl maknuti sa popusta

        if art.end_date != nil && art.end_date.to_datetime <= DateTime.now
          puts "Mičem popust sa #{art.title}!"
          art.update(on_discount: false)
        end

      end
    end
  end

end
