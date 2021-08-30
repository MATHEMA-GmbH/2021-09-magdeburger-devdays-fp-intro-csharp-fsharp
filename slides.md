---
# try also 'default' to start simple
theme: ./mathema-2021

# infos for the footer (on slides with the default-with-footer layout)
occasion: "MD DevDays 2021"
occasionLogoUrl: "img/MD-DD-Logo80.png"
company: "Mathema"
presenter: ""
contact: "martin.grotz@mathema.de | patrick.drechsler@mathema.de"

# apply any windi css classes to the current slide
class: "text-center"

highlighter: shiki

defaults:
  layout: "default-with-footer"

info: |
  ## Von C# zu F# - Einführung in die Funktionale Programmierung
  
layout: cover
---

# Von C# zu F# 
## Einführung in die Funktionale Programmierung
### Martin Grotz und Patrick Drechsler

---

## Agenda

- Grundlagen der funktionalen Programmierung
- Funktionale Programmierung mit C#
- Grundlagen von F#

---


<!-- 
===========================================================================================================
02-FP-BASICS
===========================================================================================================
-->


## FP 101

- **Functions as First Class Citizens**
- Immutability
- Pure Functions
- Composition

That's it!

---

### 1st class functions in C# #

```csharp
// Func as parameter
public string Greet(Func<string, string> greeterFunction, string name)
{
  return greeterFunction(name);
}
```

```csharp
Func<string, string> formatGreeting = (name) => $"Hello, {name}";
var greetingMessage = Greet(formatGreeting, "MD Dev Days");
// -> greetingMessage: "Hello, MD Dev Days"
```

---

### Immutability in C# #

```csharp
public class Customer
{
  public string Name { get; set; } // set -> mutable :-(
}
```

vs.

```csharp
public class Customer
{
  public Customer(string name)
  {
    Name = name;
  }
  
  public string Name { get; } // <- immutable
}
```

---

### Pure Functions in C# #

- haben niemals Seiteneffekte!
- sollten immer nach `static` umwandelbar sein

<div class="mt-3">&nbsp;</div>

### Seiteneffekte
- Implizite Parameter
- Auswirkungen nach außen von innerhalb der Funktion
- Es macht einen Unterschied, wann oder wie oft die Funktion aufgerufen wird  

---

### Syntax matters!

Classic C#

```csharp
int Add(int a, int b)
{
  return a + b;
}
```

vs.

Expression body

```csharp
int Add(int a, int b) => a + b;
```
---

Classic C#

```csharp
int Add(int a, int b)
{
  Console.WriteLine("bla"); // <- side effect!
  return a + b;
}
```

vs.

Expression body: side effects are less likely

```csharp
int Add(int a, int b) => a + b;
```

---

### Composition

- Kleine Funktionen zu großer Funktionalität zusammenstecken
- Bewusste Aufteilung des Codes in Daten, pure Funktionen und Funktionen mit Seiteneffekten
- Problem: Nicht alle Funktionen passen in Sachen Parameter und Rückgabewert zusammen

---

## Vorteile von FP
- Pure Funktionen sind leichter testbar
- Kleine Funktionen sind leichter zu erfassen
- Komposition auf allen Ebenen führt zu besserer Wandelbarkeit und Erweiterbarkeit 

---
layout: two-cols
---

### Imperativ...

**Wie** mache ich etwas 

```csharp
var incomes = new List<int>();
foreach (var person in people)
{
    if (person.Age > 18)
    {
        incomes.Add(person.Income);
    }
}

var avgIncomeAdults = incomes.Sum() / incomes.Count;
```

::right::

<v-click>

### ...versus Deklarativ

**Was** will ich erreichen?

Bsp: Filter / Map / Reduce

```csharp
var avgIncomeAdults = 
  people
    .Where(p => p.Age > 18) // "Filter"
    .Select(p => p.Income)  // "Map"
    .Average();             // "Reduce"
```

- aussagekräftiger
- weniger fehleranfällig

</v-click>

---

### Übersicht

<ImgWithCaption height="21rem" image="/content/images/fp-languages-overview.png" caption="Get Programming with F#, Isaac Abraham, Fig. 1" />

---

<!-- 
===========================================================================================================
OPTION
===========================================================================================================
-->

## Nützliche Datentypen

### Vorhandensein eines Werts

<v-click at="1">

```csharp
// Enthält die Signatur die ganze Wahrheit?
public string Stringify<T>(T data)
{
    return null;
}
```

</v-click>

<v-click at="2">

```csharp
// Sind Magic Values eine gute Idee?
public int Intify(string s)
{
    int result = -1;
    int.TryParse(s, out result);
    return result;
}
```

</v-click>

---

```csharp
public class Data
{
    public string Name;
}

public class Do
{
    public Data CreateData() => null;

    public string CreateAndUseData()
    {
        var data = CreateData();
        // kein null-Check -> ist dem Compiler egal
        return data.Name;
    }
}
```

---

## Option
```
// Pseudocode
type Option<T> = Some<T> | None
```
- entweder ein Wert ist da - dann ist er in "Some" eingepackt
- oder es ist kein Wert da, dann gibt es ein leeres "None"
- alternative Bezeichnungen: Optional, Maybe

---

## Mit Option
```csharp
public Option<int> IntifyOption(string s)
{
    int result = -1;
    bool success = int.TryParse(s, out result);
    return success ? Some(result) : None;
}
```

---

### Wie komme ich an einen eingepackten Wert ran?
> Pattern matching allows you to match a value against some patterns to select a branch of the code.

```csharp
public string Stringify<T>(Option<T> data)
{
    return data.Match(
        None: () => "",
        Some: (existingData) => existingData.ToString()
    );
}
```

---

### Vorteile
- Explizite Semantik: Wert ist da - oder eben nicht
- Auch für Nicht-Programmierer verständlich(er): "optional" vs. "nullable"
- Die Signatur von Match erzwingt eine Behandlung beider Fälle - nie wieder vergessene Null-Checks!
- Achtung: In C# bleibt das Problem, dass "Option" auch ein Objekt ist - und daher selbst null sein kann

---

## LINQ - für Listen (IEnumerable in C#)

- Allg.: Funktionen, die auf eine Liste angewendet werden
- Deklarativ


<!-- 
===========================================================================================================
LAYUMBA
===========================================================================================================
-->

---

### LaYumba

<img src="/content/images/book-csharp-fp-with-comment.png" style="height: 12rem;"/>

- NuGet Paket
- kann nicht alles
- Fokus: Didaktik (Ähnlichkeit mit F#, Haskell)
- "einfache" Variante von [language-ext](https://github.com/louthy/language-ext)

---

<img src="/content/images/language-ext-screenshot-github-0.png" style="height: 28rem;"/>

---

<img src="/content/images/language-ext-screenshot-github-1.png" style="height: 28rem;"/>

---

<img src="/content/images/language-ext-screenshot-github-2.png" style="height: 28rem;"/>

---

<img src="/content/images/language-ext-screenshot-github-3.png" style="height: 28rem;"/>

---

<img src="/content/images/language-ext-screenshot-github-4.png" style="height: 28rem;"/>

---

<img src="/content/images/language-ext-screenshot-github-5.png" style="height: 28rem;"/>

---
layout: two-cols
---

<!-- 
===========================================================================================================
FSHARP
===========================================================================================================
-->

# F# #

<img src="/content/images/fsharp256.png" style="height: 18rem;"/>

::right::

<v-click>

- Ursprünglich: Microsoft Forschungsprojekt
- Heute: Community-driven
- inspiriert von OCaml
- Multi-Paradigma
- Fokus auf funktionale Programmierung

</v-click>

<v-click>

- erzwingt keine puren Funktionen, sondern erlaubt Seiteneffekte
- Statisch typisiert
- voll integriert ins .NET Ökosystem
- C# / VB.Net Interop

</v-click>

---

## F# Besonderheiten
- Significant whitespace
- Reihenfolge der Definitionen in Datei wichtig
- Reihenfolge der Dateien im Projekt wichtig

---

## F# Immutability als Default

```fsharp
// Achtung: = ist hier keine Zuweisung, sondern heißt 
// "linke und rechte Seite sind gleich und bleiben es auch immer"
let x = 3
let add a b = a + b
let m = if 3 > 0 then 7 else 42

// Mutability nur auf Wunsch - normalerweise unnötig
let mutable y = 3
y <- 42
```

---

## F# Typ-Inferenz

```fsharp
// Typen werden automatisch abgeleitet sofern möglich
let double a = a * 2 // int -> int

// Explizite Angaben möglich
let doubleExplicit (a: int) : int = a * 2
```

---

## Currying

> Currying ist die Umwandlung einer Funktion mit mehreren Argumenten in eine Funktion mit einem Argument, die wiederum eine Funktion zurückgibt mit dem Rest der Argumente.

```fsharp
// int -> int -> int -> int
// eigentlich: int -> (int -> (int -> int))
let addThree a b c = a + b + c
```

---

## Partial Application

- Eine Funktion mit mehreren Parametern bekommt nur einen Teil ihrer Argumente übergeben - der Rest bleibt offen und kann später ausgefüllt werden
  
```fsharp
// Partial Application
let add a b = a + b // int -> (int -> (int))
let add2 = add 2 // (int -> (int))
let six = add2 4 // (int)
let ten = add2 8 // (int)
```

---

## Pipe-Operator

```fsharp
// der letzte Parameter kann mit dem Ergebnis 
// der vorherigen Expression ausgefüllt werden
let double a = a * 2
4 |> double // ergibt 8
4 |> double |> double // ergibt 16

// Beispiel aus der Praxis
let placeOrder : PlaceOrderWorkflow =
  fun unvalidatedOrder ->
    unvalidatedOrder
    |> validateOrder
    |> priceOrder
    |> acknowledgeOrder
    |> createEvents

```

---

## Discriminated Unions
```fsharp
// Discriminated Unions ("Tagged Union", "Sum Type", "Choice Type")
type Vehicle = | Bike | Car | Bus

// Pattern Matching zur Behandlung der verschiedenen Fälle
let vehicle = Bike
match vehicle with
| Bike -> "Riding a bike"
| Car -> "Driving an automobile"
| Bus -> "Going by bus"

```

---

## Discriminated Unions mit Werten
```fsharp
// auch mit unterschiedlichen(!) Daten an jedem Fall möglich
type Shape =
    | Circle of float
    | Rectangle of float * float

let c = Circle 42.42

match c with
| Circle radius -> radius * radius * System.Math.PI
| Rectangle(width, height) -> width * height
```

---
layout: two-cols
---

## Record Types

- Immutable by default
- Unmöglich einen ungültigen Record zu erzeugen
- Structural Equality

::right::

```fsharp
// Record Type
type ShoppingCart = {
    products: Product list
    total: float
    createdAt: System.DateTime
}

// Typ muss nur angegeben werden wenn nicht eindeutig
let shoppingCart = {
    products = []
    total = 42.42
    createdAt = System.DateTime.Now
}
```

---

## Structural Equality
```fsharp
// Structural Equality
type Thing = {content: string; id: int}
let thing1 = {content = "abc"; id = 15}
let thing2 = {content = "abc"; id = 15}
let equal = (thing1 = thing2) // true
```

- Record Types mit Structural Equality sind ideal, um sehr kompakt "Value Objects" ausdrücken zu können

---

## Structural Equality vs. DDD Aggregates
- Möchte man die Standard-Equality nicht, ist es best practice, Equality und Comparison zu verbieten
- dann muss explizit auf eine Eigenschaft verglichen werden (z.B. die Id)

```fsharp
[<NoEquality; NoComparison>]
type NonEquatableNonComparable = {
    Id: int
}
```

---

<!-- 
===========================================================================================================
VALUE OBJECTS
TODO: Patrick: Folien eindampfen
===========================================================================================================
-->

# Value Objects

Warum?

- Methoden sollten nicht lügen!
  - Null: NullPointerException, Null-Checks
  - Antipattern: Primitive Obsession

---

### Beispiele

```csharp
// :-(
void Einzahlen(int wert, SomeEnum waehrung) { /* ... */ }

// ;-)
void Einzahlen(Geld geld) { /* ... */ }
```

```csharp
class Kunde {
    int Alter { get; set; } // :-(
    
    // ist `i` das aktuelle Alter oder das Geburtsjahr??
    bool IstVolljaehrig(int i) { /* ... */}
}

class Kunde {
    Alter Alter { get; set; } // ;-)

    bool IstVolljaehrig(Alter alter) { /* ... */}

    bool IstVolljaehrig(Geburtsjahr geburtsjahr) { /* ... */}
}
```

---

<img src="/content/images/wikipedia-value-objects.png" style="height: 18rem;"/>

---

## Value Objects

- nur gültige Objekte erlaubt
- immutable
- equality by structure

---

### Nur gültige Objekte

Es muss bei der Erstellung gewährleistet sein, dass das Objekt gültig ist.

---

### Nur gültige Objekte

Optionen:

- Konstruktor mit allen Parametern
- statische Hilfsmethode & privater Konstruktor

```csharp
class Geld 
{
    int Betrag { get; }
    Waehrung Waehrung { get; }

    Geld(int betrag, Waehrung waehrung) {
        if (!IsValid(betrag, Waehrung)) 
            throw new InvalidGeldException();

        Betrag = betrag;
        Waehrung = waehrung;
    }

    bool IsValid(int betrag, Waehrung waehrung)
        => betrag > 0 && waehrung != Waehrung.Undefined;
}
```

---

### Immutability

Damit ein C# Objekt unveränderlich wird, muss gewährleistet sein, dass es auch **nach Erstellung nicht verändert wird**.

- interne Werte dürfen ausschließlich vom Konstruktor verändert werden
- kein public oder private setter
- kein parameterloser Konstrukor

---

### Equality by structure

Zwei Objekte sind gleich, wenn sie die gleichen Werte haben.

---

### Exkurs: Vergleichbarkeit

- Equality by reference
- Equality by id
- Equality by structure

---

### Equality by structure

Zwei Objekte sind gleich, wenn sie die gleichen Werte haben.

- `Equals` und `GetHashcode` überschreiben

```csharp
override bool Equals(Geld other)
    => other.Betrag   == this.Betrag &&
       other.Waehrung == this.Waehrung;

override int GetHashCode() { /* ... */ }
```

---

<!-- 
===========================================================================================================
fortgeschrittene_konzepte
===========================================================================================================
-->

# FP-Konzepte für die Komposition von Funktionen

- Funktor
- Monade
- Applicative
  
---
layout: two-cols
---

<!-- 
===========================================================================================================
FUNKTOR
===========================================================================================================
-->

### Problem: Wert in Container, Funktion kann nichts damit anfangen

<v-click>

```fsharp
// F#
let toUpper (s : string) = s.ToUpper()

let stringToOption (s : string) : string option =
    if String.IsNullOrWhiteSpace s then
        None
    else
        Some s

let nonEmptyStringToUpper s =
    let nonEmpty = stringToOption s
    // passt nicht: 
    // toUpper erwartet "string", bekommt "string option"
    // Häufig bei .NET Framework Funktionen
    let nonEmptyUpper = toUpper nonEmpty
```

</v-click>

::right::

<v-click>

```csharp
// C#
using LaYumba.Functional;
using static LaYumba.Functional.F;

static class X
{
  string ToUpper(string s) => s.ToUpper();

  Option<string> StringToOption(string s)
    => string.IsNullOrEmpty(s) ? None : Some(s)

  NonEmptyStringToUpper(string s)
  {
    var nonEmpty = StringToOption(s);
    // passt nicht: 
    // "string" erwartet, aber "string option" bekommen
    return ToUpper(s);
  }
}
```

</v-click>

---

### Funktor ("Mappable")

<img src="/content/resources/Funktor_1.png" style="height: 18rem;"/>

---

### Funktor ("Mappable")
- Container mit "map" Funktion (die bestimmten Regeln folgt): "Mappable"
- Bezeichnung in der FP-Welt: **Funktor**
```fsharp
  map: (a -> b) -> F a -> F b
```
- Andere Bezeichnungen für "map": fmap (z.B. in Haskell), Select (LINQ), <$>, <!>

---

### Lösung: Wert in Container mit "map" auspacken, Funktion anwenden, einpacken

```fsharp {all|12-13}
// F#
let toUpper (s : string) = s.ToUpper()

let stringToOption s =
    if String.IsNullOrWhiteSpace s then
        None
    else
        Some s

let nonEmptyStringToUpper s =
    let nonEmpty = stringToOption s
    let nonEmptyUpper = Option.map toUpper nonEmpty
    // nonEmptyUpper ist wieder "string option", obwohl toUpper "string" als Rückgabetyp hat
    // map: (a -> b) -> F a -> F b
    // map: (string -> string) -> Option<string> -> Option<string>
```

---

<!-- 
===========================================================================================================
MONADE
===========================================================================================================
-->

### Problem: Verkettung eingepackter Werte
```fsharp
let isNotEmpty (s : string) : string option =
    if String.IsNullOrWhiteSpace s then None else Some s

let toInt (input : string) : int option = 
  try
    let parsed = System.Int32.Parse(input)
    Some parsed
  with
    ex -> None

let double (num : int) : int = num * 2

let parseAndDouble input =
    let nonEmpty = isNotEmpty input
    let parsedInt = Option.map toInt nonEmpty
    // passt nicht: "int option" erwartet, 
    // aber "int option option" bekommen
    // -> Funktor mit map reicht nicht aus!
    let doubled = Option.map double parsedInt
```

---

### Monade ("Chainable")

<img src="/content/resources/Monade_1.png" style="height: 18rem;"/>

---

### Monade ("Chainable")
- Container mit "bind" Funktion (die bestimmten Regeln folgt): "Chainable"
- Bezeichnung in der FP-Welt: **Monade**
- 
```fsharp
  bind: (a -> M b) -> M a -> M b
```
- Andere Bezeichnungen für "bind": flatMap, SelectMany (LINQ), >>=

---

## Verkettung
```fsharp {all|16}
let isNotEmpty (s : string) : string option =
    if String.IsNullOrWhiteSpace s then None else Some s

let toInt (input : string) : int option = 
  try
    let parsed = System.Int32.Parse(input)
    Some parsed
  with
    ex -> None

let double (num : int) : int = num * 2

let parseAndDouble input =
    let nonEmpty = isNotEmpty input // nonEmpty ist "string option"
    // bind: (a -> M b) -> M a -> M b
    // bind: (string -> Option<int>) -> Option<string> -> Option<int>
    let parsedInt = Option.bind toInt nonEmpty // parsedInt ist jetzt "int option"
    let doubled = Option.map double parsedInt // doubled ist "int option"

```

---

<!-- 
===========================================================================================================
RAILWAY
===========================================================================================================
-->

## Exkurs: Elegante Fehlerbehandlung mit Railway Oriented Programming

Funktionale Programmierung wird oft als das "Zusammenstöpseln" von Funktionen dargestellt...

---

Beispiel:

```
f1: Eingabe string, Ausgabe int
f2: Eingabe int, Ausgabe bool

FP: Komposition von f1 und f2
f3: Eingabe string, Ausgabe bool
```

```
// FP Syntax
f1: string -> int
f2: int -> bool
f3: string -> bool
```

---

```csharp
// Klassisch ===========================================================
int F1(string s) => int.TryParse(s, out var i) ? i : 0;
bool F2(int i) => i > 0;

// "verschachtelter" Aufruf
F2(F1("1")) // -> true
F2(F1("0")) // -> false

// "composition"
bool F3(string s) => F2(F1(s));
```

```csharp
// Method Chaining =====================================================
// mit C# extension methods
static int F1(this string s) => int.TryParse(s, out var i) ? i : 0;
static bool F2(this int i) => i > 0;

// Lesbarer (erst F1, dann F2)
"1".F1().F2() // ->true
"0".F1().F2() // ->false

// Lesbarer (erst F1, dann F2)
bool F3(string s) => s.F1().F2();
```

---

- Problem: Keine standardisierte Strategie für Fehlerbehandlung 
- Wenn wir davon ausgehen, dass Funktionen auch einen Fehlerfall haben, benötigen wir einen **neuen Datentyp**, der das abbilden kann


<v-click>

<div class="mt-6">&nbsp;</div>

### Result

- kann entweder 
  - das Ergebnis beinhalten (Success)  
  - oder einen Fehlerfall (Failure)

</v-click>


---

- In Railway-Sprech bedeutet dass, dass man "2-gleisig" fährt:

- Jede **Funktion** bekommt eine Eingabe, und 
  - hat "im Bauch" eine Weiche, die entscheidet ob 
    - auf das Fehlergleis oder 
    - auf das Erfolgsgleis umgeschaltet wird.

- Die Wrapperklasse mit der **Funktion** ist das Entscheidende!

---

- In anderen Worten: die Funktionen haben aktuell 1 Eingabe (1 Gleis), und 2 Ausgaben (2 Gleise)

<img src="/content/resources/rop-tracks-Page-2.png" style="height: 18rem;"/>

---

- Man benötigt also einen Mechanismus, der eine 2-gleisige Eingabe so umwandelt, dass eine Funktion, die eine 1-gleisige Eingabe erwartet, damit umgehen kann

<img src="/content/resources/rop-tracks-Page-4.png" style="height: 18rem;"/>

---

#### Was muss dieser Mechanismus können?

- wenn die Eingabe fehlerhaft ist, muss die Funktion nichts tun, und kann den Fehler weiterreichen
- wenn die Eingabe nicht fehlerhaft ist, wird der Wert an die Funktion gegeben

---

- `Option` hat `Some(T)` und `None`

```csharp
Option<string> IsValidOpt(string s) =>
    string.IsNullOrEmpty(s)
        ? None
        : Some(s);
```

- `Result` ist ähnlich zu `Option`
- `None` wird durch `Failure` ersetzt (frei wählbar, z.B. selbst definierter Error Typ)
- In manchen Sprachen bzw. Bibliotheken heißt der Datentyp allgemeiner gefasst `Either` 

```csharp
Either<string, string> IsValidEither(string s)
    => string.IsNullOrEmpty(s)
        ? (Either<string, string>) Left("ups")
        : Right(s);
```

---

## Zurück zur Funktions-Komposition

---

<!-- 
===========================================================================================================
APPLICATIVE
===========================================================================================================
-->
### Problem: Funktion mit mehreren eingepackten Parametern

Häufiger Anwendungsfall: Validierung von Eingabedaten

```fsharp
let add a b = a + b

let onlyPositive i =
  if i > 0 then
    Some i
  else
    None

let addTwoNumbers a b =
  let positiveA = onlyPositive a
  let positiveB = onlyPositive b
  // passt nicht, 2x int erwartet, aber 2x int option übergeben
  let sum = add positiveA positiveB

  // für zwei in F# bereits vordefiniert:
  let sum = Option.map2 add positiveA positiveB

  // aber was, wenn man mehr Parameter hat?

```

---

### Applicative

<img src="/content/resources/Applicative_1_small.png" style="height: 21rem;"/>

---

### Applicative

- Container mit "apply" Funktion (die bestimmten Regeln folgt): Applicative
- Bezeichnung in der FP-Welt: **Applicative Functor**

```fsharp
  apply: AF (a -> b) -> AF a -> AF b
```

- Andere Bezeichnungen für "apply": ap, <*>

---

### Funktion mit mehreren Parametern

```fsharp
// F#
let sum a b c = a + b + c

let onlyPositive i =
    if i > 0 then Some i
    else None

let addNumbers a b c =
    let positiveA = onlyPositive a
    let positiveB = onlyPositive b
    let positiveC = onlyPositive c

    // sum ist vom Typ: (int -> int -> int -> int)
    // jede Zeile füllt ein Argument mehr aus
    // (Partial Application dank Currying)
    let (sum' : (int -> int -> int) option) = Option.map sum positiveA
    let (sum'' : (int -> int) option) = Option.apply sum' positiveB
    let (sum''' : (int) option) = Option.apply sum'' positiveC

    // Kurzschreibweise mit Infix-Operatoren
    // sum <!> positiveA <*> positiveB <*> positiveC
```

---

### Funktion mit mehreren Parametern

```csharp
// C#
Func<int, int, int, int> sum = (a, b, c) => a + b + c;

Func<int, Validation<int>> onlyPositive = i
    => i > 0
        ? Valid(i)
        : Error($"Number {i} is not positive.");

Validation<int> AddNumbers(int a, int b, int c) {
    return Valid(sum)              // returns int -> int -> int -> int
        .Apply(onlyPositive(a))    // returns int -> int -> int
        .Apply(onlyPositive(b))    // returns int -> int
        .Apply(onlyPositive(c));   // returns int

AddNumbers(1, 2, 3);    // --> Valid(6)
AddNumbers(-1, -2, -3); // --> [
                        // Error("Number -1 is not positive"),
                        // Error("Number -2 is not positive"),
                        // Error("Number -3 is not positive")
                        // ]
```

---

## Zusammenfassung Komposition

- Mit Funktor, Monade, Applicative können Funktionen zu größeren Funktionalitäten komponiert werden, die auf den ersten Blick "nicht zusammenpassen".
- Funktor, Monade, Applicative sind dabei Eigenschaften des Datentyps ("implementiert dieser die entsprechende Funktion - also map, bind, apply").
- Jeder Datentyp, der die Funktion implementiert, kann "austauschbar" verwendet werden!

---

<!-- 
===========================================================================================================
VERANSTALTUNGEN
===========================================================================================================
-->

### Interessante Veranstaltungen

#### BusConf

[https://www.bus-conf.org/](https://www.bus-conf.org/)
<img src="/content/resources/BusConf.png" style="height: 18rem;"/>

---

### Lambda Lounge Nürnberg

[https://www.meetup.com/de-DE/Lambda-Lounge-Funktionale-Programmierung-Nurnberg/](https://www.meetup.com/de-DE/Lambda-Lounge-Funktionale-Programmierung-Nurnberg/)
<img src="/content/resources/LambdaLounge.png" style="height: 18rem;"/>

---

#### Softwerkskammer

[https://www.softwerkskammer.org/groups/nuernberg](https://www.softwerkskammer.org/groups/nuernberg)
<img src="/content/resources/Softwerkskammer.png" style="height: 18rem;"/>

---

<!-- 
===========================================================================================================
F# in bestehendes Projekt integrieren
===========================================================================================================
-->

## F# - spannende Projekte

- Azure-Deployments mit [Farmer](https://compositionalit.github.io/farmer/)
  <img src="/content/resources/farmer.png" style="height: 18rem;"/>

--- 

- Webseiten mit [Fable](https://fable.io/)
  <img src="/content/resources/Fable.png" style="height: 18rem;"/>

---

- Mobile Apps mit [Fabulous](https://fsprojects.github.io/Fabulous/)
  <img src="/content/resources/Fabulous.png" style="height: 18rem;"/>

---

- Full-Stack-Webanwendungen mit dem [SAFE-Stack](https://safe-stack.github.io/)
  <img src="/content/resources/SAFE.png" style="height: 18rem;"/>

---

TODO: Danke/Kontakt Folie