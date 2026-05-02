# ================================================
#   QuizMaster - Python Quiz Game
#   Built by: Farhana Akter Mim
#   Language: Python
# ================================================

import random
import time

# ---- QUIZ QUESTIONS ----
questions = [
    {
        "question": "What is the output of print(2 ** 3)?",
        "options": ["A) 6", "B) 8", "C) 9", "D) 16"],
        "answer": "B",
        "explanation": "2 ** 3 means 2 to the power of 3 = 8"
    },
    {
        "question": "Which data type is used to store True or False in Python?",
        "options": ["A) int", "B) str", "C) bool", "D) float"],
        "answer": "C",
        "explanation": "bool (Boolean) stores True or False values"
    },
    {
        "question": "What does len('Hello') return?",
        "options": ["A) 4", "B) 5", "C) 6", "D) Error"],
        "answer": "B",
        "explanation": "len() counts characters. 'Hello' has 5 characters"
    },
    {
        "question": "Which keyword is used to define a function in Python?",
        "options": ["A) function", "B) define", "C) func", "D) def"],
        "answer": "D",
        "explanation": "def is used to define a function in Python"
    },
    {
        "question": "What is the correct way to create a list in Python?",
        "options": ["A) (1, 2, 3)", "B) {1, 2, 3}", "C) [1, 2, 3]", "D) <1, 2, 3>"],
        "answer": "C",
        "explanation": "Lists use square brackets [ ]"
    },
    {
        "question": "Which of these is a Python comment?",
        "options": ["A) // comment", "B) /* comment */", "C) # comment", "D) -- comment"],
        "answer": "C",
        "explanation": "Python uses # for single line comments"
    },
    {
        "question": "What does the range(5) function produce?",
        "options": ["A) 1,2,3,4,5", "B) 0,1,2,3,4", "C) 0,1,2,3,4,5", "D) 1,2,3,4"],
        "answer": "B",
        "explanation": "range(5) starts from 0 and goes up to (not including) 5"
    },
    {
        "question": "What is the correct way to open a file in Python?",
        "options": ["A) open('file.txt')", "B) file.open('file.txt')", "C) read('file.txt')", "D) load('file.txt')"],
        "answer": "A",
        "explanation": "open() is the built-in function to open files in Python"
    },
    {
        "question": "Which method adds an item to the end of a list?",
        "options": ["A) add()", "B) insert()", "C) append()", "D) push()"],
        "answer": "C",
        "explanation": "append() adds an item to the end of a list"
    },
    {
        "question": "What is the output of type(3.14)?",
        "options": ["A) int", "B) str", "C) double", "D) float"],
        "answer": "D",
        "explanation": "3.14 is a decimal number, so its type is float"
    },
]

# ---- HELPER FUNCTIONS ----
def print_banner():
    print("\n" + "="*50)
    print("   🐍  QUIZMASTER - Python Edition  🐍")
    print("   Built by: Farhana Akter Mim")
    print("="*50 + "\n")

def print_score(score, total):
    percentage = (score / total) * 100
    print("\n" + "="*50)
    print(f"  📊 YOUR RESULTS")
    print("="*50)
    print(f"  Score: {score} / {total}")
    print(f"  Percentage: {percentage:.1f}%")
    if percentage == 100:
        print("  🏆 PERFECT SCORE! Amazing job!")
    elif percentage >= 80:
        print("  🌟 Excellent! You're a Python pro!")
    elif percentage >= 60:
        print("  👍 Good job! Keep practicing!")
    elif percentage >= 40:
        print("  💪 Not bad! Review and try again!")
    else:
        print("  📚 Keep studying! You'll get there!")
    print("="*50 + "\n")

# ---- MAIN GAME ----
def run_quiz():
    print_banner()
    print("Welcome to QuizMaster! 🎉")
    name = input("Enter your name: ").strip()
    if not name:
        name = "Player"
    print(f"\nHello, {name}! Let's test your Python knowledge!")
    print("You will be asked 10 questions. Good luck! 🍀\n")
    time.sleep(1)

    # Shuffle questions for variety
    quiz = random.sample(questions, min(10, len(questions)))

    score = 0
    wrong_answers = []

    for i, q in enumerate(quiz, 1):
        print(f"\n{'─'*50}")
        print(f"  Question {i} of {len(quiz)}")
        print(f"{'─'*50}")
        print(f"\n  {q['question']}\n")
        for opt in q['options']:
            print(f"    {opt}")
        print()

        while True:
            answer = input("  Your answer (A/B/C/D): ").strip().upper()
            if answer in ['A', 'B', 'C', 'D']:
                break
            print("  ⚠️  Please enter A, B, C or D")

        if answer == q['answer']:
            print("  ✅ Correct! Well done!")
            score += 1
        else:
            print(f"  ❌ Wrong! The correct answer was {q['answer']}")
            print(f"  💡 {q['explanation']}")
            wrong_answers.append(q)

        time.sleep(0.5)

    # Show results
    print_score(score, len(quiz))

    if wrong_answers:
        review = input("Would you like to review your wrong answers? (yes/no): ").strip().lower()
        if review in ['yes', 'y']:
            print("\n📖 REVIEW - Questions you got wrong:\n")
            for q in wrong_answers:
                print(f"  Q: {q['question']}")
                print(f"  ✅ Answer: {q['answer']}")
                print(f"  💡 {q['explanation']}\n")

    again = input("\nPlay again? (yes/no): ").strip().lower()
    if again in ['yes', 'y']:
        run_quiz()
    else:
        print(f"\nThanks for playing, {name}! Keep coding! 🐍✨\n")

# ---- RUN ----
if __name__ == "__main__":
    run_quiz()
