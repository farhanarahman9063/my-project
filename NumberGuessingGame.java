// ================================================
//   Number Guessing Game
//   Built by: Farhana Akter Mim
//   Language: Java
// ================================================

import java.util.Scanner;
import java.util.Random;

public class NumberGuessingGame {

    // ---- CONSTANTS ----
    static final int MIN_NUMBER = 1;
    static final int MAX_NUMBER = 100;
    static final int MAX_ATTEMPTS = 10;

    // ---- GAME STATS ----
    static int totalGames   = 0;
    static int totalWins    = 0;
    static int bestScore    = Integer.MAX_VALUE; // fewest attempts
    static Scanner scanner  = new Scanner(System.in);
    static Random random    = new Random();

    // ---- MAIN METHOD ----
    public static void main(String[] args) {
        printBanner();
        String playerName = getPlayerName();

        boolean playing = true;
        while (playing) {
            playGame(playerName);
            playing = askPlayAgain();
        }

        printFinalStats(playerName);
        scanner.close();
    }

    // ---- PRINT BANNER ----
    static void printBanner() {
        System.out.println("\n" + "=".repeat(52));
        System.out.println("   ☕  NUMBER GUESSING GAME  ☕");
        System.out.println("   Built by: Farhana Akter Mim");
        System.out.println("   Language: Java");
        System.out.println("=".repeat(52));
    }

    // ---- GET PLAYER NAME ----
    static String getPlayerName() {
        System.out.print("\nEnter your name: ");
        String name = scanner.nextLine().trim();
        if (name.isEmpty()) name = "Player";
        System.out.println("\nWelcome, " + name + "! 🎉");
        System.out.println("I'm thinking of a number between " 
            + MIN_NUMBER + " and " + MAX_NUMBER + ".");
        System.out.println("You have " + MAX_ATTEMPTS + " attempts. Good luck! 🍀\n");
        return name;
    }

    // ---- PLAY ONE GAME ----
    static void playGame(String playerName) {
        int secretNumber = random.nextInt(MAX_NUMBER - MIN_NUMBER + 1) + MIN_NUMBER;
        int attempts     = 0;
        boolean won      = false;

        totalGames++;

        while (attempts < MAX_ATTEMPTS && !won) {
            int remaining = MAX_ATTEMPTS - attempts;
            System.out.println("─".repeat(40));
            System.out.println("Attempts remaining: " + remaining);

            // Get hint after 3 wrong guesses
            if (attempts >= 3) {
                printHint(secretNumber, attempts);
            }

            int guess = getValidGuess(attempts + 1);
            attempts++;

            if (guess == secretNumber) {
                won = true;
                totalWins++;
                if (attempts < bestScore) bestScore = attempts;

                System.out.println("\n🎉 CORRECT! The number was " + secretNumber + "!");
                System.out.println("You got it in " + attempts + " attempt(s)!");
                printWinMessage(attempts);

            } else if (guess < secretNumber) {
                System.out.println("📈 Too LOW! Try a higher number.");
                printCloseness(guess, secretNumber);
            } else {
                System.out.println("📉 Too HIGH! Try a lower number.");
                printCloseness(guess, secretNumber);
            }
        }

        if (!won) {
            System.out.println("\n💔 Game Over! The number was " + secretNumber + ".");
            System.out.println("Better luck next time, " + playerName + "!");
        }

        System.out.println("\nGames: " + totalGames + 
                           "  |  Wins: " + totalWins + 
                           "  |  Win Rate: " + getWinRate() + "%");
    }

    // ---- GET VALID GUESS ----
    static int getValidGuess(int attemptNum) {
        while (true) {
            System.out.print("Attempt " + attemptNum + " - Enter your guess: ");
            try {
                String input = scanner.nextLine().trim();
                int guess = Integer.parseInt(input);
                if (guess < MIN_NUMBER || guess > MAX_NUMBER) {
                    System.out.println("⚠️  Please enter a number between " 
                        + MIN_NUMBER + " and " + MAX_NUMBER + "!");
                } else {
                    return guess;
                }
            } catch (NumberFormatException e) {
                System.out.println("⚠️  Invalid input! Please enter a number.");
            }
        }
    }

    // ---- PRINT CLOSENESS ----
    static void printCloseness(int guess, int secret) {
        int diff = Math.abs(guess - secret);
        if      (diff <= 5)  System.out.println("🔥 Very close! Just " + diff + " away!");
        else if (diff <= 15) System.out.println("😊 Getting warmer! " + diff + " away.");
        else if (diff <= 30) System.out.println("😐 Getting colder... " + diff + " away.");
        else                 System.out.println("🥶 Very far! " + diff + " away.");
    }

    // ---- PRINT HINT ----
    static void printHint(int secret, int attempts) {
        System.out.print("💡 Hint: The number is ");
        if (secret % 2 == 0) System.out.print("EVEN");
        else                  System.out.print("ODD");

        if (attempts >= 6) {
            // Give range hint
            int lower = Math.max(MIN_NUMBER, secret - 10);
            int upper = Math.min(MAX_NUMBER, secret + 10);
            System.out.print(" and between " + lower + " and " + upper);
        }
        System.out.println(".");
    }

    // ---- WIN MESSAGE ----
    static void printWinMessage(int attempts) {
        if      (attempts == 1)  System.out.println("🏆 INCREDIBLE! First try!");
        else if (attempts <= 3)  System.out.println("🌟 Amazing! That was very fast!");
        else if (attempts <= 6)  System.out.println("👍 Great job! Well played!");
        else if (attempts <= 8)  System.out.println("😊 Good work! You got it!");
        else                     System.out.println("😅 Phew! Just made it!");
    }

    // ---- GET WIN RATE ----
    static int getWinRate() {
        if (totalGames == 0) return 0;
        return (int) Math.round((totalWins * 100.0) / totalGames);
    }

    // ---- ASK PLAY AGAIN ----
    static boolean askPlayAgain() {
        System.out.print("\nPlay again? (yes/no): ");
        String answer = scanner.nextLine().trim().toLowerCase();
        System.out.println();
        return answer.equals("yes") || answer.equals("y");
    }

    // ---- FINAL STATS ----
    static void printFinalStats(String playerName) {
        System.out.println("\n" + "=".repeat(52));
        System.out.println("  📊 FINAL STATS - " + playerName);
        System.out.println("=".repeat(52));
        System.out.println("  Total Games Played : " + totalGames);
        System.out.println("  Total Wins         : " + totalWins);
        System.out.println("  Win Rate           : " + getWinRate() + "%");
        if (bestScore != Integer.MAX_VALUE) {
            System.out.println("  Best Score         : " + bestScore + " attempt(s)");
        }
        System.out.println("=".repeat(52));
        System.out.println("  Thanks for playing! Keep coding! ☕✨");
        System.out.println("=".repeat(52) + "\n");
    }
}
