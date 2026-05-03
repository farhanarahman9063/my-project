// ================================================
//   ATM Banking System
//   Built by: Farhana Akter Mim
//   Language: C++
// ================================================

#include <iostream>
#include <string>
#include <vector>
#include <iomanip>
#include <ctime>
#include <algorithm>
using namespace std;

// ---- TRANSACTION STRUCT ----
struct Transaction {
    string type;
    double amount;
    double balance;
    string date;
};

// ---- ACCOUNT CLASS ----
class Account {
private:
    string ownerName;
    string accountNumber;
    string pin;
    double balance;
    vector<Transaction> history;

public:
    Account(string name, string accNum, string p, double initialBalance) {
        ownerName     = name;
        accountNumber = accNum;
        pin           = p;
        balance       = initialBalance;
    }

    string getName()    { return ownerName; }
    string getAccNum()  { return accountNumber; }
    double getBalance() { return balance; }

    bool verifyPin(string inputPin) { return inputPin == pin; }

    string getDate() {
        time_t now = time(0);
        tm* ltm = localtime(&now);
        string d = to_string(1900 + ltm->tm_year) + "-"
                 + (ltm->tm_mon+1 < 10 ? "0" : "") + to_string(ltm->tm_mon+1) + "-"
                 + (ltm->tm_mday  < 10 ? "0" : "") + to_string(ltm->tm_mday);
        return d;
    }

    bool deposit(double amount) {
        if (amount <= 0) return false;
        balance += amount;
        history.push_back({"Deposit", amount, balance, getDate()});
        return true;
    }

    bool withdraw(double amount) {
        if (amount <= 0 || amount > balance) return false;
        balance -= amount;
        history.push_back({"Withdraw", amount, balance, getDate()});
        return true;
    }

    bool transfer(Account& target, double amount) {
        if (amount <= 0 || amount > balance) return false;
        balance        -= amount;
        target.balance += amount;
        history.push_back({"Transfer Out", amount, balance, getDate()});
        target.history.push_back({"Transfer In", amount, target.balance, getDate()});
        return true;
    }

    void printStatement() {
        cout << "\n  " << string(44,'-') << "\n";
        cout << "  MINI STATEMENT - " << ownerName << "\n";
        cout << "  Account: " << accountNumber << "\n";
        cout << "  " << string(44,'-') << "\n";
        cout << "  " << left << setw(12) << "Date" << setw(14) << "Type"
             << setw(10) << "Amount" << "Balance\n";
        cout << "  " << string(44,'-') << "\n";
        if (history.empty()) {
            cout << "  No transactions yet.\n";
        } else {
            int start = max(0,(int)history.size()-5);
            for (int i = start; i < (int)history.size(); i++) {
                auto& t = history[i];
                cout << "  " << left << setw(12) << t.date << setw(14) << t.type
                     << "$" << setw(9) << fixed << setprecision(2) << t.amount
                     << "$" << fixed << setprecision(2) << t.balance << "\n";
            }
        }
        cout << "  " << string(44,'-') << "\n";
        cout << "  Balance: $" << fixed << setprecision(2) << balance << "\n";
        cout << "  " << string(44,'-') << "\n";
    }
};

// ---- ATM CLASS ----
class ATM {
private:
    vector<Account> accounts;
    Account* current = nullptr;

public:
    ATM() {
        accounts.push_back(Account("Farhana Akter Mim","ACC-001","1234",5000.00));
        accounts.push_back(Account("Rahim Uddin",      "ACC-002","5678",3200.00));
        accounts.push_back(Account("Priya Sen",        "ACC-003","9012",7500.00));
    }

    void printBanner() {
        cout << "\n" << string(48,'=') << "\n";
        cout << "   ATM BANKING SYSTEM\n";
        cout << "   Built by: Farhana Akter Mim | C++\n";
        cout << string(48,'=') << "\n";
        cout << "  Sample Accounts:\n";
        cout << "  ACC-001 PIN:1234 | ACC-002 PIN:5678 | ACC-003 PIN:9012\n";
        cout << string(48,'=') << "\n";
    }

    void line() { cout << "  " << string(44,'-') << "\n"; }

    Account* findAccount(string num) {
        for (auto& a : accounts)
            if (a.getAccNum() == num) return &a;
        return nullptr;
    }

    double getAmount(string prompt) {
        double amt;
        while (true) {
            cout << "  " << prompt;
            if (cin >> amt && amt > 0) { cin.ignore(); return amt; }
            cin.clear(); cin.ignore(1000,'\n');
            cout << "  Invalid amount!\n";
        }
    }

    bool login() {
        string num, pin;
        cout << "\n  Account Number: "; cin >> num; cin.ignore();
        Account* acc = findAccount(num);
        if (!acc) { cout << "  Account not found!\n"; return false; }
        for (int i = 3; i > 0; i--) {
            cout << "  PIN (" << i << " attempts left): "; cin >> pin; cin.ignore();
            if (acc->verifyPin(pin)) { current = acc; cout << "\n  Welcome, " << acc->getName() << "!\n"; return true; }
            cout << "  Wrong PIN!\n";
        }
        cout << "  Account locked!\n"; return false;
    }

    void showMenu() {
        cout << "\n  ========= MENU =========\n";
        cout << "  1. Check Balance\n";
        cout << "  2. Deposit\n";
        cout << "  3. Withdraw\n";
        cout << "  4. Transfer\n";
        cout << "  5. Mini Statement\n";
        cout << "  6. Logout\n";
        cout << "  ========================\n";
        cout << "  Choice: ";
    }

    void run() {
        printBanner();
        while (true) {
            cout << "\n  [1] Login  [2] Exit\n  Choose: ";
            int c; cin >> c; cin.ignore();
            if (c == 2) { cout << "\n  Goodbye!\n"; break; }
            if (!login()) continue;

            bool session = true;
            while (session) {
                showMenu();
                int opt; cin >> opt; cin.ignore();
                string tgt; double amt;
                Account* target;
                switch (opt) {
                    case 1:
                        line();
                        cout << "  Balance: $" << fixed << setprecision(2) << current->getBalance() << "\n";
                        line(); break;
                    case 2:
                        amt = getAmount("Deposit amount: $");
                        cout << (current->deposit(amt) ? "  Deposited!\n" : "  Failed!\n");
                        cout << "  Balance: $" << fixed << setprecision(2) << current->getBalance() << "\n"; break;
                    case 3:
                        cout << "  Available: $" << fixed << setprecision(2) << current->getBalance() << "\n";
                        amt = getAmount("Withdraw amount: $");
                        cout << (current->withdraw(amt) ? "  Withdrawn!\n" : "  Insufficient funds!\n");
                        cout << "  Balance: $" << fixed << setprecision(2) << current->getBalance() << "\n"; break;
                    case 4:
                        cout << "  Target account: "; cin >> tgt; cin.ignore();
                        target = findAccount(tgt);
                        if (!target) { cout << "  Account not found!\n"; break; }
                        amt = getAmount("Transfer amount: $");
                        if (current->transfer(*target, amt))
                            cout << "  Transferred $" << fixed << setprecision(2) << amt << " to " << target->getName() << "\n";
                        else cout << "  Transfer failed!\n"; break;
                    case 5: current->printStatement(); break;
                    case 6: cout << "  Goodbye, " << current->getName() << "!\n"; current = nullptr; session = false; break;
                    default: cout << "  Invalid option!\n";
                }
            }
        }
    }
};

int main() {
    ATM atm;
    atm.run();
    return 0;
}
