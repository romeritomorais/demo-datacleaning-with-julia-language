using CSV;
using DataFrames;
using Statistics;

;ls -n

movies = DataFrame(CSV.File("movies.csv"))
first(movies, 5)

names(movies)

eltype.(eachcol(movies))

size(movies)

rename!(movies, :filmtv_id => :id,       
               :titolo_originale => :titulo,
               :titolo_italiano  => :null,
               :anno    =>          :ano,
               :genere     =>       :genero,
               :durata     =>       :duracao,
               :paese       =>      :pais,
               :registi    =>       :diretor,
               :attori    =>        :atores,
               :voto_medio     =>   :voto_medio,
               :voti          =>    :voto,
               :descrizione   =>    :discircao,
               :note           =>   :nota,
               :miglior_commento => :m_comentario)

names(movies)

select!(movies, Not([:id              
                     :null             
                     :pais        
                     :diretor     
                     :atores             
                     :discircao   
                     :nota        
                     :m_comentario
                     ]))

mean(movies.duracao)

median(movies.duracao)

sum(movies.duracao)

sort!(movies, :ano)

movies = dropmissing(movies)

movies[occursin.("Biblico", movies.genero), :]

groupby(movies, [:genero])

by(movies, [:genero], movies -> mean(movies[:, :voto_medio]))

movies.titulo

movies[!, :duracao_hm] .= movies.duracao / 60

movies[:, [:titulo, :duracao_hm]]

select!(movies, Not(:duracao))

names(movies)

movies[.&(movies.ano .> 2000, movies.duracao_hm .== 1), :][[:titulo, :ano, :duracao_hm]]

CSV.write("filmes.csv", movies, append=false)

;head  filmes.csv


