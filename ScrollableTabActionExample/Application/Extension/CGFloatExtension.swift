//
//  CGFloatExtension.swift
//  ScrollableTabActionExample
//
//  Created by 酒井文也 on 2024/05/10.
//

import Foundation

// MEMO: 補間（既知点の間の値を推定すること）の考え方を利用して、Drag処理に対応する変化量を算出する
// 参考: 線形補間の計算式と近似誤差
// https://manabitimes.jp/math/1422

extension CGFloat {

    // MARK: - Function

    // 座標点の配列を元にした線形補間の計算を利用した座標位置
    func calculateInterpolate(inputInterpolateRange: [CGFloat], outputInterpolateRange: [CGFloat]) -> CGFloat {

        let positionX = self
        let length = inputInterpolateRange.count - 1

        // 最初に与えられた値が最初の入力値より小さい場合は、最初の出力値を返す
        if positionX <= inputInterpolateRange[0] { return outputInterpolateRange[0] }

        // 与えられた点の間を近似する処理を実行する
        // 👉 この値を利用する事でDrag移動時に伴って移動するオブジェクトに対して滑らかな動きを付与する事が可能
        for index in 1...length {

            // 2点間(x1, y1) & (x2, y2)の座標を算出する
            let x1 = inputInterpolateRange[index - 1]
            let x2 = inputInterpolateRange[index]
            let y1 = outputInterpolateRange[index - 1]
            let y2 = outputInterpolateRange[index]

            // 算出した座標値を元に線形補間の計算を実行して変化量を算出する
            // 👉 線形補間の計算式: y1 + ((y2 - y1) / (x2 - x1)) * (positionX - x1)
            if positionX <= inputInterpolateRange[index] {
                let positionY = y1 + ((y2 - y1) / (x2 - x1)) * (positionX - x1)
                return positionY
            }
        }

        // 線形補間の計算で算出できなかった場合は、出力値の最後の値を返す様にする
        return outputInterpolateRange[length]
    }
}
