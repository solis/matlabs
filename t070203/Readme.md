## Общая постановка задачи

Решение смешанной задачи методом разделения переменных
При реализации данного проекта необходимо:

1. Исходя из заданных параметров, сформулировать задачу
2. Найти решение, пользуясь средствами, предоставляемыми Maple (при необходимости для
промежуточных аналитических расчетов) и MATLAB (для окончательного численного
решения)
3. Результаты расчета сохранить в файле (файлах)
4. Численный результат сравнить с точным решением
5. Оформить отчет, включающий формулировку задачи и основные шаги (приведение гра-
ничных условий к однородным, задача Штурма-Лиувилля и ее решение, задача для на-
хождения Tk)


Параметрами являются:
* Точное решение
* Тип уравнения – гиперболическое (Г) или параболическое (П)
* Тип граничных условий на каждой из границ (1-го, 2-го или 3-го рода)
* Область [0..L] × [0..Tmax], причем L задается, Tmax выбирается самостоятельно
* Физические константы a и h
Результатом работы являются файл(ы) с расчитанными значениями функции u(x, t) и гра-
фики (поверхности и линии уровня точного и приближенного решений, абсолютной и относи-
тельной погрешностей и т.п. - все, что дополнительно решит включить исполнитель). 

Проект должен состоять из двух программ - расчетной (например t071203.m) и визуализирующей (на-
пример t071203v.m). Первая выполняет расчеты и сохраняет результаты в файле(ах), вторая -
выполняет визуализацию. Удовлетворительным считается решение с относительной погрешно-
стью не более 5%

## Задача для этого варианта 

* a = 3
* L = 1
* h = 1
* Граничные условия : слева и справа II-ого рода.
* Функция u(x, t) = −sin(2 x − 3)cos(2t + 3)exp(−3t^2−t)
* Тип уравнения : Параболическое. 

Полученная задача: 

  * du/dt = d^2 / (dx)^2 + f(x, t)  
  * du/dx (0)  
  * du/dx (L)  
  * u(x, 0)
  


  
  
