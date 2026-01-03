import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import javax.swing.Timer;

class Question {
    String question;
    String[] options;
    int correctIndex;

    Question(String q, String[] o, int correct) {
        question = q;
        options = o;
        correctIndex = correct;
    }
}

public class QuizApp extends JFrame implements ActionListener {
    Question[] questions;
    int current = 0, score = 0;
    JLabel questionLabel, timerLabel;
    JRadioButton[] options;
    ButtonGroup group;
    JButton nextButton, submitButton;
    Timer timer;
    int timeLeft = 20;
    String userName;

    QuizApp(String name) {
        userName = name;
        setTitle("Java Quiz Application");
        setSize(550, 350);
        setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        setLayout(new BorderLayout(10, 10));

        // Questions
        questions = new Question[]{
            new Question("1. What is the capital of France?",
                    new String[]{"Berlin", "Paris", "Rome", "Madrid"}, 1),
            new Question("2. Who invented Java?",
                    new String[]{"James Gosling", "Bjarne Stroustrup", "Guido van Rossum", "Dennis Ritchie"}, 0),
            new Question("3. Which company owns Java now?",
                    new String[]{"Google", "Oracle", "Microsoft", "IBM"}, 1),
            new Question("4. Which keyword is used to inherit a class in Java?",
                    new String[]{"implement", "this", "extends", "inherits"}, 2),
            new Question("5. What is JVM short for?",
                    new String[]{"Java Virtual Machine", "Java Visual Model", "Just Virtual Memory", "Java Variable Method"}, 0)
        };

        // Header panel with timer
        JPanel topPanel = new JPanel(new BorderLayout());
        questionLabel = new JLabel();
        questionLabel.setFont(new Font("Arial", Font.BOLD, 16));
        timerLabel = new JLabel("Time left: 20s");
        timerLabel.setFont(new Font("Arial", Font.PLAIN, 14));
        timerLabel.setForeground(Color.RED);
        topPanel.add(questionLabel, BorderLayout.WEST);
        topPanel.add(timerLabel, BorderLayout.EAST);
        add(topPanel, BorderLayout.NORTH);

        // Options (radio buttons)
        JPanel optionsPanel = new JPanel();
        optionsPanel.setLayout(new GridLayout(4, 1));
        options = new JRadioButton[4];
        group = new ButtonGroup();
        for (int i = 0; i < 4; i++) {
            options[i] = new JRadioButton();
            group.add(options[i]);
            optionsPanel.add(options[i]);
        }
        add(optionsPanel, BorderLayout.CENTER);

        // Buttons
        JPanel buttonPanel = new JPanel();
        nextButton = new JButton("Next");
        submitButton = new JButton("Submit");
        nextButton.addActionListener(this);
        submitButton.addActionListener(this);
        buttonPanel.add(nextButton);
        buttonPanel.add(submitButton);
        add(buttonPanel, BorderLayout.SOUTH);

        // Timer setup (20 seconds per question)
        timer = new Timer(1000, new ActionListener() {
            public void actionPerformed(ActionEvent e) {
                timeLeft--;
                timerLabel.setText("Time left: " + timeLeft + "s");
                if (timeLeft == 0) {
                    nextQuestion(); // auto move
                }
            }
        });

        loadQuestion();
        timer.start();
        setVisible(true);
    }

    void loadQuestion() {
        if (current < questions.length) {
            Question q = questions[current];
            questionLabel.setText(q.question);
            for (int i = 0; i < 4; i++) {
                options[i].setText(q.options[i]);
            }
            group.clearSelection();
            timeLeft = 20; // reset timer
            timerLabel.setText("Time left: " + timeLeft + "s");
        }
    }

    boolean checkAnswer() {
        int selected = -1;
        for (int i = 0; i < 4; i++) {
            if (options[i].isSelected()) selected = i;
        }
        return selected == questions[current].correctIndex;
    }

    void nextQuestion() {
        if (checkAnswer()) score++;
        current++;
        if (current >= questions.length) {
            timer.stop();
            showResults();
        } else {
            loadQuestion();
        }
    }

    void showResults() {
        getContentPane().removeAll(); // clear window
        repaint();

        double percentage = ((double) score / questions.length) * 100;
        String message;
        if (percentage >= 80) message = "Excellent!";
        else if (percentage >= 50) message = "Good Job!";
        else message = "Try Again!";

        JPanel resultPanel = new JPanel(new GridLayout(5, 1));
        resultPanel.add(new JLabel("🎯 Quiz Completed!"));
        resultPanel.add(new JLabel("Name: " + userName));
        resultPanel.add(new JLabel("Score: " + score + "/" + questions.length));
        resultPanel.add(new JLabel(String.format("Percentage: %.2f%%", percentage)));
        resultPanel.add(new JLabel("Feedback: " + message));

        for (Component c : resultPanel.getComponents()) {
            ((JLabel)c).setHorizontalAlignment(SwingConstants.CENTER);
            c.setFont(new Font("Arial", Font.PLAIN, 16));
        }

        add(resultPanel, BorderLayout.CENTER);
        revalidate();
        repaint();
    }

    public void actionPerformed(ActionEvent e) {
        if (e.getSource() == nextButton) {
            nextQuestion();
        } else if (e.getSource() == submitButton) {
            timer.stop();
            nextQuestion();
        }
    }

    public static void main(String[] args) {
        String name = JOptionPane.showInputDialog("Enter your name:");
        if (name != null && !name.trim().isEmpty()) {
            new QuizApp(name);
        } else {
            JOptionPane.showMessageDialog(null, "Name is required to start the quiz!");
        }
    }
}
