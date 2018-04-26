% Programmer: Mark Tarakai
% CS 3500: Programming Languages & Translators
% Homework #7: Introduction to Prolog

% Define relations (procedures)
monster/1.
dead/1.
alive/1.
undead/1.
vampire/1.
werewolf/1.
ghost/1.
poltergeist/1.
hybrid/1.
looksLike/2.
thrivesOn/2.

% Translate prompt information into Prolog statements
vampire(X) :- undead(X), looksLike(X, 'human'), thrivesOn(X, 'blood').
vampire('dracula').
vampire('edward cullen').
werewolf(X) :- alive(X), looksLike(X, 'wolf'), thrivesOn(X, 'flesh').
werewolf('sam uley').
ghost(X) :- dead(X), looksLike(X, 'human'), thrivesOn(X, 'fear').
ghost('caspar').
poltergeist(X) :- ghost(X).
poltergeist('peeves').
hybrid(X) :- vampire(X), werewolf(X).
hybrid('michael corvin').
monster(X) :- vampire(X), ghost(X), hybrid(X).
