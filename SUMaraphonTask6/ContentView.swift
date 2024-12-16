//
//  ContentView.swift
//  SUMaraphonTask6
//
//  Created by A on 14.12.2024.
//
//

/*
 🏁 Новое задание «Стройный Ряд». Сдать до 16 Декабря 21:00.
 
 На экране квадраты. По нажатию на любой из них меняется порядок: горизонтальный -> диагональ -> горизонтальный.
 
 - Изменения анимированные.
 - Работает для любого кол-во квадратов.
 - Квадраты ⚠️ не выходит за Safe Area, но занимают все доступное место. Для горизонтали вписываются по ширине, для диагонали вписываются по высоте.
 */

import SwiftUI

struct ContentView: View {
    
    @State var isDiagonal = false
    
    // Горизонтальные настройки
    let spacing: CGFloat = 8 // расстояние между квадратами
    
    // Настройки квадратов
    let kvadratBGColor: Color = .blue // фон квадрата
    let kvadratCornerRadius: CGFloat = 6
    var kvadratCount: Int = 7 // любое кол-во
    
    var body: some View {
        
        GeometryReader { geometry in
            
            // Ширина и Высота экрана
            let screenWidth = geometry.size.width
            let screenHeight = geometry.size.height
            
            // Высота квадрата для диагонального режима
            let kvadratHeight = screenHeight / CGFloat(kvadratCount)
            
            // Размер квадрата, учитываем расстояния между квадратами только для горизонтального режима
            let kvadratSize = isDiagonal
            ? kvadratHeight
            : (screenWidth - (spacing * CGFloat(kvadratCount - 1))) / CGFloat(kvadratCount)
            
            ForEach(0..<kvadratCount, id: \.self) { index in
                let i = CGFloat(index)
                
                Kvadrat(size: kvadratSize, bgColor: kvadratBGColor, cornerRadius: kvadratCornerRadius)
                    .position(
                        x: calculateXPosition(index: i, size: kvadratSize, screenWidth: screenWidth),
                        y: calculateYPosition(index: i, size: kvadratSize, screenHeight: screenHeight, kvadratHeight: kvadratHeight)
                    )
                
            }//: ForEach
            
        }//: GeometryReader
        .contentShape(Rectangle())
        .onTapGesture {
            
            withAnimation(.spring(duration: 0.4)) {
                isDiagonal.toggle()
           
            }
        }
    }
    
    // X положение квадрата
    func calculateXPosition(index: CGFloat, size: CGFloat, screenWidth: CGFloat) -> CGFloat {
        
        if isDiagonal {
         
            return index * (screenWidth - size) / CGFloat(kvadratCount - 1) + size/2
       
        } else {
          
            return index * (size + spacing) + size/2
            
        }
        
    }
    
    // Y положение квадрата
    func calculateYPosition(index: CGFloat, size: CGFloat, screenHeight: CGFloat, kvadratHeight: CGFloat) -> CGFloat {
        
        if isDiagonal {
            
            return screenHeight - (index * kvadratHeight + size/2)
            
        } else {
            
            return screenHeight/2
            
        }
        
    }
}

struct Kvadrat: View {
    
    let size: CGFloat
    let bgColor: Color
    let cornerRadius: CGFloat
    
    var body: some View {
        
        RoundedRectangle(cornerRadius: cornerRadius)
            .frame(width: size, height: size)
            .foregroundStyle(bgColor)
        
    }
    
}


#Preview {
    ContentView()
}
