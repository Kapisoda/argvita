desc "Ovo se zove svakih 10 min da provjeri popust!"

task :set_discount => :environment do
  puts "Ušao u set discount!"

  @articles = Article.where(for_sale: true)

  @articles.each do |art|
    if art.on_discount != nil && art.on_discount == true

      if art.start_date <= DateTime.now
        art.on_discount = true
        art.save
      end

    else

      if art.end_date >= DateTime.now
        art.on_discount = false
        art.save
      end

    end
  end

end