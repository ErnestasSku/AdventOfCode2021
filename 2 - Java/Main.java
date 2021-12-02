import java.io.File;
import java.io.FileNotFoundException;
import java.util.Scanner;

// Day 2 advent of code solution in java

public class Main{
    public static void main(String[] args) {
        
        try{
            File file = new File("input.txt");
            Scanner reader = new Scanner(file);
            Solver part1 = new Solver();
            Solver part2 = new Solver();
            while(reader.hasNextLine()){
                String data = reader.nextLine();
                part1.compute(data);
                part2.compute2(data);
                
            }
            System.out.println(part1.answer());
            System.out.println(part2.answer());
            reader.close();
        } catch (FileNotFoundException e) {
            System.out.println("File not found");
        }

    }
}

class Solver{
    int distance;
    int depth;
    int aim;

    public Solver()
    {
        distance = 0;
        depth = 0;
        aim = 0;
    }

    // Part 1 solution
    void compute(String data)
    {
        String[] arr = data.split(" ");
        String command = arr[0];
        int number = Integer.parseInt(arr[1]);
        
        if(command.equals("forward"))
            distance += number;
        else if (command.equals("down"))
            depth += number;
        else if (command.equals("up"))
            depth -= number;
    }

    // Part 2 solution
    void compute2(String data)
    {
        String[] arr = data.split(" ");
        String command = arr[0];
        int number = Integer.parseInt(arr[1]);
        
        if(command.equals("forward"))
        {
            distance += number;
            depth += (number * aim);
        }
        else if (command.equals("down"))
            aim += number;
        else if (command.equals("up"))
            aim -= number;
    }

    int answer()
    {
        return distance * depth;
    }

}