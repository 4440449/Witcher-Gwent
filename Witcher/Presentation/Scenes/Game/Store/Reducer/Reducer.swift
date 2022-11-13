//
//  Reducer.swift
//  Witcher
//
//  Created by Maxim Terpugov on 02.11.2022.
//


//  AKA Game script
struct Reducer {
    
    func execute(action: Action, state: State) -> State {
        var newState = state
        
        switch action {
        case .handOutCards:
            let gameSetup = state.gameSetup
            newState.gamblingTable.player.availableCards = handOutCards(gameSetup.player.cardDeck, count: 5)
            newState.gamblingTable.ai.availableCards = handOutCards(gameSetup.ai.cardDeck, count: 5)
            
        case .playerMove(let params):
            // Увеличиваем счет на кол-во поинтов карты
            let cardPower = state.gamblingTable.player.availableCards[params.cardIndex].type.params().damage
            newState.gamblingTable.player.score += cardPower
            // Удаляем карту из доступной колоды
            newState.gamblingTable.player.availableCards.remove(at: params.cardIndex)
            // Проверяем пасовал ли бот и определяем доступность ходов
            if !newState.gamblingTable.ai.foldInRound {
                newState.gamblingTable.ai.isMoveAvailable = true
                newState.gamblingTable.player.isMoveAvailable = false
            }
            // Вычитаем доступный ход
            newState.gamblingTable.player.availableMoves -= 1
            // Увеличиваем общий счетчик сделанных ходов в раунде
            newState.gamblingTable.round.currentCountOfMovesInRound += 1
            // Валидируем раунд на оставшиеся ходы
            newState = movesValidator(newState)
            
        case .playerFold:
            // Запрещаем ходить в данном раунде
            newState.gamblingTable.player.isMoveAvailable = false
            newState.gamblingTable.player.foldInRound = true
            // Увеличиваем общий счетчик ходов раунда на оставшиеся ходы пользователя
            newState.gamblingTable.round.currentCountOfMovesInRound += newState.gamblingTable.player.availableMoves
            // Обнуляем доступное количество ходов
            newState.gamblingTable.player.availableMoves = 0
            // Проверяем пасовал ли бот и определяем доступность его хода
            if !newState.gamblingTable.ai.foldInRound {
                newState.gamblingTable.ai.isMoveAvailable = true
            }
            // Валидируем раунд на оставшиеся ходы
            newState = movesValidator(newState)
            
        case .aiMove(params: let params):
            // Увеличиваем счет на кол-во поинтов карты
            let cardPower = state.gamblingTable.ai.availableCards[params.cardIndex].type.params().damage
            newState.gamblingTable.ai.score += cardPower
            // Удаляем карту из доступной колоды
            newState.gamblingTable.ai.availableCards.remove(at: params.cardIndex)
            // Проверяем пасовал ли пользователь и определяем доступность хода
            if !newState.gamblingTable.player.foldInRound {
                newState.gamblingTable.ai.isMoveAvailable = false
                newState.gamblingTable.player.isMoveAvailable = true
            }
            // Вычитаем доступный ход
            newState.gamblingTable.ai.availableMoves -= 1
            // Увеличиваем общий счетчик сделанных ходов в раунде
            newState.gamblingTable.round.currentCountOfMovesInRound += 1
            // Валидируем на оставшиеся ходы
            newState = movesValidator(newState)
            
        case .aiFold:
            // Запрещаем ходить в данном раунде
            newState.gamblingTable.ai.isMoveAvailable = false
            newState.gamblingTable.ai.foldInRound = true
            // Увеличиваем общий счетчик ходов раунда на оставшиеся ходы пользователя
            newState.gamblingTable.round.currentCountOfMovesInRound += newState.gamblingTable.ai.availableMoves
            // Обнуляем доступное количество ходов
            newState.gamblingTable.ai.availableMoves = 0
            // Проверяем пасовал ли пользователь и определяем доступность его хода
            if !newState.gamblingTable.player.foldInRound {
                newState.gamblingTable.player.isMoveAvailable = true
            }
            // Валидируем на оставшиеся ходы
            newState = movesValidator(newState)
        }
        return newState
    }
    
    
    // MARK: - Private
    
    // Moves
    private func movesValidator(_ state: State) -> State {
        // Проверяем остались ли еще ходы в раунде
        let totalMovesInRound = state.gameSetup.totalCountOfMovesInRound
        if state.gamblingTable.round.currentCountOfMovesInRound == totalMovesInRound {
            return roundValidator(state)
        } else {
            return state
        }
    }
    
    // Round
    private func roundValidator(_ state: State) -> State {
        // Подготавливаем данные к новому раунду
        var newState = prepareNewRoundData(state)
        // Определяем закончена ли игра
        let winCondition = (newState.gameSetup.totalCountOfRounds / 2) + 1
        if newState.gamblingTable.round.playerWonRounds == winCondition {
            newState.gamblingTable.game.playerWon += 1
            return prepareNewGameData(newState)
        } else
        if newState.gamblingTable.round.aiWonRounds == winCondition {
            newState.gamblingTable.game.aiWon += 1
            return prepareNewGameData(newState)
        } else {
            return newState
        }
    }
    
    // New Round Data
    private func prepareNewRoundData(_ state: State) -> State {
        var newState = state
        let playerScore = newState.gamblingTable.player.score
        let aiScore = newState.gamblingTable.ai.score
        // Увеличиваем счетчик сыгранных раундов
        newState.gamblingTable.round.currentCountOfRounds += 1
        // Опредляем победителя в раунде
        if aiScore > playerScore {
            newState.gamblingTable.round.aiWonRounds += 1
        } else {
            newState.gamblingTable.round.playerWonRounds += 1
        }
        // Выдаем доп карты
        let availableCardDeck = newState.gameSetup.player.cardDeck.filter {
            !newState.gamblingTable.player.availableCards.contains($0)
        }
        newState.gamblingTable.player.availableCards.append(contentsOf: handOutCards(availableCardDeck, count: 3))
        newState.gamblingTable.ai.availableCards.append(contentsOf: handOutCards(availableCardDeck, count: 3))
        // Обнуляем параметры
        newState.gamblingTable.player.score = 0
        newState.gamblingTable.player.availableMoves = newState.gameSetup.totalCountOfMovesInRound / 2
        newState.gamblingTable.ai.score = 0
        newState.gamblingTable.ai.availableMoves = newState.gameSetup.totalCountOfMovesInRound / 2
        newState.gamblingTable.round.currentCountOfMovesInRound = 0
        
        newState.gamblingTable.player.foldInRound = false
        newState.gamblingTable.player.isMoveAvailable = true
        
        newState.gamblingTable.ai.foldInRound = false
        newState.gamblingTable.ai.isMoveAvailable = false
        return newState
    }
    
    // New Game Data
    private func prepareNewGameData(_ state: State) -> State {
        var newState = state
        let gameSetup = state.gameSetup
        // player
        let newPlayerAvailableCards = handOutCards(gameSetup.player.cardDeck, count: 5)
        newState.gamblingTable.player = .init(score: 0,
                                              availableCards: newPlayerAvailableCards,
                                              foldInRound: false,
                                              isMoveAvailable: true,
                                              availableMoves: gameSetup.totalCountOfMovesInRound / 2)
        // ai
        let newAiAvailableCards = handOutCards(gameSetup.ai.cardDeck, count: 5)
        newState.gamblingTable.ai = .init(score: 0,
                                          availableCards: newAiAvailableCards,
                                          foldInRound: false,
                                          isMoveAvailable: false,
                                          availableMoves: gameSetup.totalCountOfMovesInRound / 2)
        
        newState.gamblingTable.round = .init(aiWonRounds: 0,
                                             playerWonRounds: 0,
                                             currentCountOfMovesInRound: 0,
                                             currentCountOfRounds: 1)
        return newState
    }
    
    //
    private func handOutCards(_ cards: [Card], count: Int) -> [Card] {
        guard cards.count >= count else { fatalError() }
        var shuffledDeck = [Card]()
        for _ in 0...count - 1 {
            shuffledDeck.append(cards.randomElement()!)
        }
        return shuffledDeck
    }
    
}

