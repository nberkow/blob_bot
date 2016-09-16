
png("/home/ubuntu/tbot/random_plot.png")


## Get a palette of contiguous colors from the rainbow
get_block_palette <- function(n, m, s){
  range = rainbow(m)
  max_start = m - (n*s)
  start = floor(runif(1, 1, max_start))
  j = 1:n * (s-1)
  i = start:(start+n-1) + j
  return(range[i])
}

## Get random colors from a pre-set palette
get_palette <- function(n, m){
  
  f = floor(runif(1, 1, 7))
  
  # by default get a block palette
  p = get_block_palette(n, m, floor(runif(1,1,3)))
  
  # otherwise pick one of the pre-mades
  if (f == 1){
    p = rainbow(m, alpha = 1)
  } 
  
  if (f == 1){
    p = heat.colors(m, alpha = 1)
  }
  
  if (f == 2){
    p = topo.colors(m, alpha = 1)
  }
  
  if (f == 3){
    p = cm.colors(m, alpha = 1)
  }
  
  m = 100
  
  #return(p[floor(runif(n, 1, m))])
  return(p)
}

get_shapes <-function(n){
  allowed_shapes = 15:19
  s = 1:n * 0 + 1
  return(sample(allowed_shapes, 1) * s)
}


get_coords <- function(n){
  
  # pick a distribution
  f = floor(runif(1, 1, 4))
  if (f == 1){
    coord = runif(n * 2)
  }
  
  if (f == 2){
    lambda = runif(1, 1, n*2)
    coord = rpois(n*2, lambda)
  }
  
  if (f == 3){
    shape = runif(1,1,n*2)
    scale = runif(1,1,n*2)
    coord = rgamma(n*2, shape, scale)
  }
  
  # in some cases add noise
  f = floor(runif(1, 1, 3))
  if (f == 3){
    noise = runif(n*2)
    coord = coord * (noise**0.5)
  }
  
  # in some cases make the coords related to the indexes
  f = floor(runif(1, 1, 4))
  if (f == 3){
    coord = sort(coord)
    a = mean(coord)
    coord = runif(n, a/2, a*1.5) #jitter
  }  
  
  return(coord)
  
}

get_sizes <- function(n){
  f = floor(runif(1, 1, 4))
 
  # by default sizes are all the same
  s = 1:n * 0 + 1
  r = runif(1, 5, 25)
  sizes = s * r
  
  # somtimes they are gausian
  if (f == 2){
    sizes = rnorm(n, r)
  }
  
  # sometimes they are poisson
  if (f == 3){
    lambda = runif(1, 1, n*2)
    sizes = rpois(n, lambda)
  }
  return(sizes)
}


rorshache <- function(colors){
  plot((-10:10) * 2.5, (-10:10) * 2.5, type = "n", axes = FALSE, ylab = NA, xlab = NA)
  for (x in 1:floor(runif(1,5,15))){
    
    if (is.na(colors)){
      c = 'black'
    }
    else{
      c = colors[x]
    }
    
    r = rnorm(1, 10 - x / 10 + .1, 1)
    
    a = 1
    b = 2
    
    i = runif(20, -r, r)
    j = runif(1, -1-r, 1+r)
    k = runif(1, -1-r, 1+r)
    
    x = c(1 - j, 1 - j, 2 + k, 2 + k) + i[1:4] - 15
    y = c(1 - j, 2 + k, 2 + k, 1 - j) + i[5:8]
    polygon(x, y, col = c, border = NA)
    
    x = 0 - (c(1 - j, 1 - j, 2 + k, 2 + k) + i[1:4]) + 15
    y = c(1 - j, 2 + k, 2 + k, 1 - j) + i[5:8]
    polygon(x, y, col = c, border = NA)
  }
}

polygons <- function(colors){
  plot((-7:7) * 2.5, (-7:7) * 2.5, type = "n", axes = FALSE, ylab = NA, xlab = NA)
  for (x in 1:floor(runif(1,5,15))){
    
    r = rnorm(1, 10 - x / 10 + .1, 1)
    
    if (is.na(colors)){
      i = floor(runif(1,1, 6))
      c = rainbow(5)[i]
    }
    else{
      c = colors[x]
    }
    
    a = 1
    b = 2
    
    i = runif(20, -r, r)
    j = runif(1, -1-r, 1+r)
    k = runif(1, -1-r, 1+r)
    
    x = c(1 - j, 1 - j, 2 + k, 2 + k) + i[1:4]
    y = c(1 - j, 2 + k, 2 + k, 1 - j) + i[5:8]
    polygon(x, y, col = 'red', border = NA)
  }
}




random_plot <- function(){
  
  n = floor(runif(1, 10, 100))
  coord = get_coords(n*2)
  colors = palette = get_palette(n, n * 5)
  shapes = get_shapes(n)
  sizes = get_sizes(n)
  
  x = coord[((1:n) * 2) - 1]
  y = coord[(1:n) *  2]
  
  xl = c(min(x) - mean(x)*.25, max(x) +  mean(x)*.25)
  yl = c(min(y) - mean(y)*.25, max(y) +  mean(y)*.25)
  
  ptype = rbinom(1, prob = 0.5, size = 1)

  # do a scatter plot
  if (ptype == 1){
    plot(x, y, pch = shapes, col = colors, axes=F, ylab = '', xlab = '',  cex = sizes, xlim = xl, ylim =yl)
  }
  
  # plot polygons
  if (ptype == 0){
    polytype = rbinom(1, prob = 0.4, size = 1)
    c = rbinom(1, prob = 0.2, size = 1)
    if (c == 1){
      colors = palette = get_palette(n, n * 5)
    }
    else{
      colors = NA
    }
    
    if (polytype == 1){
      rorshache(colors)
    }
    else {
      polygons(colors)
    }
  }
  

  # occassionally do a overlay of another set of points
  for (i in 1:3){
    n = n * floor(runif(1,1,5))
    new_coord = get_coords(n*2)
    new_coord = (new_coord - mean(coord))/sd(coord)
    
    x = new_coord[((1:n) * 2) - 1]
    y = new_coord[(1:n) *  2]
    
    colors = palette = get_palette(n, n * 4)
    shapes = get_shapes(n)
    sizes = get_sizes(n)/10
    points(x, y, pch = shapes, col = colors,  cex = sizes)
    
  }
}

#png("/home/nberk/random_plot.png")#, height=500, width=500)
par(mar=c(0,0,0,0))
random_plot()
dev.off()




##############





