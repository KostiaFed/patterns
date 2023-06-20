# початкові значення
x0 = 0.6
y0 = 0.8
# Діапазон значень
pool = 7..16 # [a, b]
# Крок
h = 0.1
# Допустима кількість знаків після коми
hit = 4

# Інтеграл
def integrated(x, y)
  # yup = x + cos(y/2.25)
  0.5 * x * x + Math.sin(y / Math.sqrt(10)) * x
end

yn = y0
for step in pool do
  f = integrated(step * h, yn)
  yn += f * h
  # p (step * h).round(1).to_s + ' | ' + f.round(hit).to_s
  p f.round(hit)
end
