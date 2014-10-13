
-module(ebola).

%  This is a simple R0 simulator for diseases, to show why none of us should
%  really be all that worried about ebola.
%
%  R0 is a measure of how fast a disease will grow:
%    http://en.wikipedia.org/wiki/Basic_reproduction_number





-export([

    model/0,

    contagion/2,
      contagion/3

]).





model() ->

    % numbers from wikipedia references above

    [ { ebola,      1.81  },
      { the_flu,    2.77  },
      { aids,       4.82  },
      { mumps,      5.06  },
      { rubella,    6.53  },
      { diphtheria, 6.92  },
      { pertussis,  13.81 },
      { measles,    17.27 }
    ].





contagion(Days, Diseases) ->

    InitialVector = lists:duplicate(length(Diseases), 1),
    contagion(Days, InitialVector, Diseases).




contagion(0, States, Diseases) ->

    [ {L,N} || { N, {L, _} } <- lists:zip(States, Diseases) ];





contagion(Days, States, Diseases) ->

    NewVector = [ N + (N * R0) || { N, {_, R0} } <- lists:zip(States, Diseases) ],
    LabelledNewVector = [ {L, N + (N * R0)} || { N, {L, R0} } <- lists:zip(States, Diseases) ],
    io:format("~w~n~n",[LabelledNewVector]),
    contagion(Days-1, NewVector, Diseases).
