//
//  LessonView.swift
//  tail
//
//  Created by Jack Allen on 06/06/2020.
//  Copyright © 2020 Jack Allen. All rights reserved.
//

import SwiftUI

let grey: UIColor = UIColor(red: 0.96, green: 0.96, blue: 0.96, alpha: 1.00);

class Question: ObservableObject {
    init(_ text: String, _ choices: [Choice]) {
        self.text = text
        self.choices = choices
    }
    
    var text: String
    var choices: [Choice]
    @Published var answer: String?
    
    func setAnswer(_ answer: String) {
        self.answer = answer
    }
}

struct LessonView: View {
    @Binding var showLession: Bool
    
    var questions: [Question] = [
        Question("What glass is a Mojito served in?", [
            Choice("Tea Cup", false),
            Choice("Double Old-fashioned", false),
            Choice("Collins", true),
            Choice("Sling", false)
        ]),
        Question("What kind of Juice is in a Mojito?", [
            Choice("Orange", false),
            Choice("Lime", true),
            Choice("Lemon", false),
            Choice("Pineapple", false)
        ]),
        Question("How much white rum goes into a single Mojito?", [
            Choice("24ml", false),
            Choice("30ml", false),
            Choice("45ml", false),
            Choice("60ml", true)
        ])
    ]
    
    @State var questionIndex: Int = 0
    
    func goToNext() -> Void {
        if (self.questions.count - 1 == self.questionIndex) {
            self.showLession = false
            return;
        }
        
        self.questionIndex += 1
    }
    
    func currentQuestion() -> Question {
        return self.questions[self.questionIndex]
    }
    
    func onAnswer(_ answer: String) {
        self.questions[self.questionIndex].setAnswer(answer)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.goToNext()
        }
    }
    
    var body: some View {
        ZStack {
            Color(grey).edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading) {

                LessonHeader()

                QuestionView(question: self.currentQuestion(), onAnswer: { answer in
                    self.onAnswer(answer)
                })

            }.padding()
        }

    }
}

struct Choice {
    init(_ text: String, _ isAnswer: Bool) {
        self.text = text
        self.isAnswer = isAnswer
    }

    var text: String
    var isAnswer: Bool
}

struct QuestionView: View {
    @ObservedObject var question: Question
    var onAnswer: (String) -> Void

    var body: some View {

        VStack(alignment: .leading) {
            Text(self.question.text)
                    .font(.system(size: 24))
                    .padding(.bottom)
            MultipleChoiceView(question: self.question, onSelected: { choice in
                print(choice)
                if (self.question.answer != nil) {
                    return
                }
                
                self.onAnswer(choice)
            })
        }
    }
}

struct LessonHeader: View {
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: "xmark")
                    .font(.system(size: 25, weight: .semibold))
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            Progress()
        }
                .padding(.bottom, 25)
                .padding(.trailing)
    }
}

struct Progress: View {
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(#colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)))
            Rectangle()
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 3)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))

        }
    }
}

struct MultipleChoiceView: View {
    var question: Question

    var onSelected: (String) -> Void

    var body: some View {

        VStack(alignment: .leading) {
            Text("Choose the correct answer")
                    .font(.subheadline)
                    .padding(.bottom, 10)
                    .foregroundColor(.gray)

            ForEach(self.question.choices, id: \.text) { choice in
                ChoiceView(
                        choice: choice,
                        onSelected: self.onSelected,
                        selected: self.question.answer
                )
                        .padding(.bottom)
            }

            Spacer()
        }
    }
}

struct ChoiceView: View {
    var choice: Choice

    var onSelected: (String) -> Void
    var selected: String?

    func isSelected() -> Bool {
        return self.selected == self.choice.text
    }

    func isRight() -> Bool {
        return isSelected() && self.choice.isAnswer
    }

    func answered() -> Bool {
        return self.selected != nil
    }

    func isWrong() -> Bool {
        return self.answered() && self.selected != self.choice.text
    }

    var body: some View {

        let background = isSelected() ? (isRight() ? Color(#colorLiteral(red: 0.1020897846, green: 0.7859295685, blue: 0.1129261599, alpha: 1)) : Color(#colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1))) : .white
        let foreground = isSelected() ? (isRight() ? Color(#colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)) : Color(#colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1))) : .black
        let shadow = Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
        let weight: Font.Weight = isSelected() ? .semibold : .regular

        let view =

                Button(action: {
                    self.onSelected(self.choice.text)
                }) {
                    Text(self.choice.text)
                            .fontWeight(weight)
                    Spacer()
                }
                        .foregroundColor(foreground)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(background)
                        .cornerRadius(10)
                        .shadow(color: shadow, radius: 1, x: 0, y: 1)
                        .disabled(self.answered())

        return view;
    }
}

struct LessonView_Previews: PreviewProvider {
    
    static var previews: some View {
        LessonView(showLession: .constant(true))
    }
}
