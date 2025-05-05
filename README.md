# Projekt gry komputerowej kółka HelloIT, zespołu Calico
Tytuł: Amongomia
Silnik: Godot Engine v4.3
Grafika/Assety: Custom
Typ gry: Platformówka 2D z elementami fabularnymi i sekwencjami "visual novel"


## 9 grudnia 2024r.:
Projekt jest w bardzo wczesnej fazie - dopiero co powstał. Wrzucony został initial commit do etapu 1. obecnego taska, projekt spełnia naprawdę podstawowe założenia tego etapu - jest to praktycznie szkielet, na którym wraz z feedbackami i kolejnymi pracami nad nim będzie dostosowywany i będzie nabierał kształtu.
Jedyna placeholderowa tekstura to tekstura postaci w res://assets - druga jest obecnie nieużywana.

## 10 marca 2025r.:
Nastąpiło kilka updateów projektu, oto ich krótkie podsumowanie, a poniżej nieco bardziej szczegółowa dokumentacja obecnego stanu projektu:
 - dodano podstawę systemu interakcji - po wejściu do strefy interakcji i naciśnięciu dedykowanego przycisku, gra wykonuje odpowiednie działania - w jednym z przypadków jest to przeniesienie gracza do poziomu 2D - nowej sceny
 - rozpoczęto pracę nad przykładowym poziomem (level_test_2D), dodano defaultowy movement postaci (potem nieco usprawniony, by był nieco lepszy do kontrolowania), oraz dodano odbijanie się od głowy przeciwnika
 - w tym tygodniu (6-10 marca) rozpoczęto pracę nad projektem poziomu, wg wrzuconego na discordzie schematu poziomu tutorialowego, w tym celu utworzono przykładowy tileset oraz utworzono tymczasowy parallax background.
Stan projektu na dzisiaj:
 - Focus na level_test_2D
 - W projekcie poziomu wykorzystano TileMapLayer z tymczasowym tilesetem, grid 16x16 pikseli. W tilesecie znajdują się też platformy, które posiadają nieco inny hitbox - zostało to uwzględnione
 - Rozmiar postaci zbliżony do formatu 16x32 piksele, hitbox nieco zwęższony (12x32 piksele)
 - Utworzony został początek poziomu tutorialowego, zawierający dwie pierwsze sekcje platformowe
 - Istnieje stacjonarny (na razie ukryty) przeciwnik, od którego można się odbić, skacząc mu na głowę

Ewentualne kwestie dotyczące szczegółowości raportu (głównie dane techniczne - rozmiary pikseli, dokładna charakterystyka ruchu postaci i SI przeciwników, dokładny plan mapy) zostawię do uzgodnienia - na tym etapie nie sądzę, by to było jeszcze aż tak koniecznie, ale jestem otwarty na propozycje dot. komunikacji i współpracy nad projektem żeby nic się nie rozjechało

## 16 kwietnia 2025r.:
Obecnie ukończono podstawowy system checkpointów i respawnu postaci w levelu platformowym. Zrezygnowano z początkowych planów hub'u 3D, zamiast tego utworzona zostanie sekcja Visual Novel z wprowadzeniem fabularnym (do zrobienia w przyszłości).
System checkpointów jest dość ubogi, a gracz póki co umiera tylko od upadku w przepaść (tymczasowo oznaczoną prowizorycznymi płomieniami), ale cały system zdaje się funkcjonować sprawnie (nie był bardzo mocno testowany, ale nie jest też rozbudowany, sam szkielet wywołań przebiega sprawnie).
Oczekiwany feedback, póki co do zrobienia jest jeszcze:
  - menu główne, z możliwością wczytania zapisanej gry
  - co za tym idzie: system zapisu stanu gry (który na razie zapisze stan obecnego poziomu)
  - UI: menu w grze
Na razie planuję skupić się na stworzeniu menu głównego (które będzie nas witało po uruchomieniu gry), z którego będzie można wczytać nową grę lub kontynuować zapisaną (na razie tylko na podstawie level_test_2D).

## 28 kwietnia 2025r.:
Nastąpił dość spory progress, na tym etapie rozwijane (i, przynajmniej bazowo, po części gotowe) elementy projektu to:
  - menu główne - zrobiona została znaczna część graficznego interfejsu (bez efektów/animacji, przynajmniej na razie), a jedyną dostępną w tym momencie funkcją jest rozpoczęcie nowej gry. Powoduje to przełączenie sceny na (na razie) poziom platformowy 2D
  - sam poziom platformowy - przygotowane zostały tilesheety do platform/obiektów platformowych, oraz grafiki levela - umożliwiło to rozpoczęcie zastępowania placeholderów tymi właśnie docelowymi materiałami. Nadal brakuje pewnych wartych dodania elementów, takich jak trawa przy wystających blokach oraz sposobu zamaskowania przepaści, ale całość wygląda już w miarę ciekawie. 
Podobnie jak z menu głównym, potencjalne efekty mogą być dodane raczej na późniejszym etapie rozwoju - póki co, główne skupienie będzie teraz na funkcjonalnych częściach projektu:
  - zapisywanie i wczytywanie stanu (na razie) poziomu (docelowo całej gry, włącznie z segmentami dialogowymi)
  - dopracowanie funkcjonalności menu głównego - dodanie paska na dole z datą+godziną i przyciskiem wyjścia z gry
  - in-game menu

## 5 maja 2025r.:
Prace przebiegały głównie na dwóch scenach: 
  - menu główne - małe poprawki: 
	  - graficzne, związane ze wyglądem stanów przycisków
	  - funkcjonalne - dodanie paska nawigacji, na którym znajduje się aktualna data i godzina (pobierane z systemu) oraz przycisk wyjścia z gry, stylizowany na przycisk wyłączenia komputera
  - menu pauzy (in-game menu) - dodano możliwość zapauzowania gry klawiszem ESCAPE i wyświetlenia interfejsu menu pauzy. Gracz ma w nim możliwość (na razie w funkcjonalnie uproszczonej, docelowej wersji):
	  - kontynuowania gry (WZNÓW, przycisk minimalizacji na górnym pasku lub ponowne kliknięcie klawisza ESCAPE)
	  - wyjścia do menu głównego (i w przyszłości połowicznego/-, automatycznego zapisu stanu gru)
	  - wyłączenia gry (WYJDŹ Z GRY, przycisk wyłączenia okna na górnym pasku)

Dalsze plany na ten moment:
  - skupić się na systemie zapisów gry (póki co samego poziomu)
  - zacząć dodawać przeciwników do poziomu - wliczając w to ich zachowanie, animacje oraz konsekwencje starć z nimi
  - ewentualne rzeczy po konsultacji z zarządcą projektu
