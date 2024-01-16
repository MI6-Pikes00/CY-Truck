### horizontal histogram
reset session
set terminal pngcairo size 1920,1080 enhanced font 'Arial,12'
set output './images/graph_d1test.png'
# create some random test data
set table $Data
    set samples 2000
    plot './temp/top_conducteurs.csv' u (invnorm(rand(0))+2):(1)   w table, \
         '' u (invnorm(rand(0))-2):(0.5) w table
unset table

binwidth = 0.25
bin(x)   = binwidth * floor(x/binwidth)

set table $Histo
    plot $Data u (bin($1)):2 smooth freq
unset table

set style fill solid 0.5

plot $Histo u ($2/2):1:($2/2):(binwidth/2.) w boxxy ti "Horizontal Histogram"
### end of script