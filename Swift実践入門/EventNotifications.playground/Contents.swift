import UIKit

var greeting = "Hello, playground"

// イベント通知
// デリゲートパターン　別オブジェクトへの処理の移譲
// 実装方法
// ゲームを表現するプログラムを実装
// プレイヤーの人数とゲームの開始、終了時の処理を移譲するためのインターフェースを
// GameDelegateプロトコルとして宣言。
protocol GameDelegate: class {
    var numberOfPlayers: Int { get }
    func gameDidStart(_ game: Game)
    func gameDidEnd(_ game: Game)
}
// GameDelegateプロトコルに準拠したクラス
class TwoPersonsGameDelegate: GameDelegate {
    var numberOfPlayers: Int { return 2 }
    func gameDidStart(_ game: Game) {
        print("Game Start")

    }
    func gameDidEnd(_ game: Game) {
        print("Game End")
    }
}

class Game {
    // weakキーワード共にプロパティを宣言すると、弱参照となる。
    // 弱参照は循環参照の解消に用いる。
    weak var delegate: GameDelegate?
    // Gameクラスはstart()メソッドの中で、delegateプロパティを通じて、
    // デリゲート先にプレイヤーの人数を問い合わせている。
    func start() {
        print("Number of players is \(delegate?.numberOfPlayers ?? 1)")
        // ゲームの開始をデリゲート先に伝える
        delegate?.gameDidStart(self)
        print("Playing")
        // ゲームの終了をデリゲート先に伝える
        delegate?.gameDidEnd(self)
        print("End Playing")
    }
}
let delegate = TwoPersonsGameDelegate()
let twoPersonGame = Game()
twoPersonGame.delegate = delegate
twoPersonGame.start()

