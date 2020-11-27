--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

local GOLD_TROPHY_IMAGE = love.graphics.newImage('gold_trophy.png')
local SILVER_TROPHY_IMAGE = love.graphics.newImage('silver_trophy.png')
local BRONZE_TROPHY_IMAGE = love.graphics.newImage('bronze_trophy.png')
local NO_TROPHY_IMAGE = love.graphics.newImage('no_trophy.png')

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, VIRTUAL_HEIGHT * 0.1, VIRTUAL_WIDTH, 'center')

    -- draws trophy depending on score (specification)
    if self.score < 2 then
        love.graphics.draw(NO_TROPHY_IMAGE, VIRTUAL_WIDTH / 2 - 60, VIRTUAL_HEIGHT / 2 - 70) 
    elseif self.score >= 2 and self.score < 4 then
        love.graphics.draw(BRONZE_TROPHY_IMAGE, VIRTUAL_WIDTH / 2 - 60, VIRTUAL_HEIGHT / 2 - 70)   
    elseif self.score>= 4 and self.score < 6 then
        love.graphics.draw(SILVER_TROPHY_IMAGE, VIRTUAL_WIDTH / 2 - 60, VIRTUAL_HEIGHT / 2 - 70)   
    else
        love.graphics.draw(GOLD_TROPHY_IMAGE, VIRTUAL_WIDTH / 2 - 60, VIRTUAL_HEIGHT / 2 - 70)   
    end

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, VIRTUAL_HEIGHT * 0.73, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, VIRTUAL_HEIGHT * 0.85, VIRTUAL_WIDTH, 'center')
end