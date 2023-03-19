-- This function converts a number of beats and subdivisions in milliseconds, based on the global tempo.
-- Usage: beatsToMs(__beats, __subdiv)
-- __beats: The number of beats. For reference, a microgame runs for 8 beats.
-- __subdiv: (optional) The number of subdivisions. For reference, 4 subdivisions make up one beat.

function beatsToMs(__beats, __subdiv)
    local beats = __beats
    local subdiv = __subdiv or 0
    local tempo = gameSettings.tempo
    local duration = ((beats + (subdiv / 4)) * (60000 / tempo))
    return duration
end