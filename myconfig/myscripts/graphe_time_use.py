import matplotlib.pyplot as plt
import subprocess

script_path = "time_use t"
process = subprocess.Popen(script_path, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
output, error = process.communicate()

if error:
    print("Erreur du script Bash :")
    print(error.decode('utf-8'))
    exit(1)

res_command = output.decode('utf-8')
res_command = res_command.split("\n")
dates = []
string_values = []
values = []

for i in range(7):
    one_data = res_command[i].split(":")
    dates.append(one_data[0].strip())
    string_values.append(one_data[1].strip())

for string_value in string_values:
    string_value_split = string_value.split()
    if len(string_value_split) == 2:
        values.append(int(string_value_split[0]))
    elif len(string_value_split) == 4:
        values.append(int(string_value_split[0]) * 60 + int(string_value_split[2]))

values.reverse()
string_values.reverse()
dates.reverse()

resolution_dpi = 100
fig_width = 1700 / resolution_dpi
fig_height = 800 / resolution_dpi
fig, ax = plt.subplots(figsize=(fig_width, fig_height))

plt.title("Temps d'utilisation total: " + res_command[8].split(":")[1])
plt.rcParams.update({'font.size': 14})
barres = plt.bar(dates, values, color='blue')
plt.ylabel("Durée d'utilisation (min)")

stat = res_command[9].split(":")
title_average = stat[0].strip()
string_average= stat[1].strip()

string_value_split = string_average.split()
average = 0
if len(string_value_split) == 2:
    average = int(string_value_split[0])
elif len(string_value_split) == 4:
    average = int(string_value_split[0]) * 60 + int(string_value_split[2])

plt.axhline(y=average, color="orange", linestyle='-', label=title_average)
plt.text(7.4, average, f'{string_average}', ha='right', va='center', color="orange")

for barre, valeur in zip(barres, string_values):
    plt.text(barre.get_x() + barre.get_width() / 2, barre.get_height() + average * 0.1, str(valeur), ha='center', va='top')

plt.show()
