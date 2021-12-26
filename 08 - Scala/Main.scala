//Day 8 in Scala.
//Scala is an interesting language, although as I didn't knew much about Scala at that moment, the solution might not be the most cleanest.
import java.io._
import scala.io.Source
import java.util.ArrayList

object Main {

    def main(args: Array[String]) {
       
        var values = new ArrayList[Data]()

        for (line <- Source.fromFile("input.txt").getLines) {
            var a = new Data(line)
            values.add(new Data(line))
        }
        
        part1(values)
        part2(values)

    }

    def part1(values: ArrayList[Data]) {
        var counter : Int = 0
        for (i <- 0 until values.size) {
            for (j <- 0 until values.get(i).second.size ) {
                // 2 3 4 7
                if(values.get(i).second(j).length() == 2 ||
                   values.get(i).second(j).length() == 3 ||
                   values.get(i).second(j).length() == 4 ||
                   values.get(i).second(j).length() == 7)
                   counter += 1;
            }
        }
        println(counter);
    }

    def part2(values: ArrayList[Data]) {

        var temp: String = "";
        var sum: Int = 0;
        for (i <- 0 until values.size) {
            temp = ""
            for (j <- 0 until values.get(i).second.size ) {
                
                if(values.get(i).second(j).length() == 2) temp += "1"
                else if(values.get(i).second(j).length() == 3) temp += "7"
                else if(values.get(i).second(j).length() == 4) temp += "4"
                else if(values.get(i).second(j).length() == 7) temp += "8"
                
                else if(values.get(i).second(j).length() == 5)
                {
                    var code: String = findElOf((values.get(i).first), 2)
                    var first :Boolean = checkStr(values.get(i).second(j), code.split("")(0))
                    var second :Boolean = checkStr(values.get(i).second(j), code.split("")(1))

                    if(first && second) {
                        temp += "3"
                    }
                    else {
                        var one: String = findElOf((values.get(i).first), 2)
                        var four: String = findElOf((values.get(i).first), 4)

                        var charArr = four.split("").diff(one.split(""))
                        var code = charArr.mkString

                        var first :Boolean = checkStr(values.get(i).second(j), code.split("")(0))
                        var second :Boolean = checkStr(values.get(i).second(j), code.split("")(1))

                        if(first && second)
                            temp += "5"
                        else
                            temp += "2"
                    }

                }
                else if(values.get(i).second(j).length() == 6)
                {
                    
                    var one: String = findElOf((values.get(i).first), 2)
                    var four: String = findElOf((values.get(i).first), 4)

                    var charArr = four.split("").diff(one.split(""))
                    var code = charArr.mkString

                    var first :Boolean = checkStr(values.get(i).second(j), code.split("")(0))
                    var second :Boolean = checkStr(values.get(i).second(j), code.split("")(1))

                    // var found: Boolean = checkStr(values.get(i).second(j), one)

                    if (first && second) {
                        code = findElOf((values.get(i).first), 2)
                        var first :Boolean = checkStr(values.get(i).second(j), code.split("")(0))
                        var second :Boolean = checkStr(values.get(i).second(j), code.split("")(1))

                        if (first && second)
                            temp += "9"
                        else
                            temp += "6"
                    }
                    else {
                        temp += "0"
                        
                    }
                }
            }
            sum += temp.toInt
            // println(temp)
        }
        print(sum)
    }

    def checkStr(string: String, code: String) :Boolean = {
        var a = code.split("")
        //print(a(0))
        for( i <- 0 until a.size) {  
            if(string.contains(code(i)))
                return true;
        }
        return false;
    }

    def findElOf(arr: Array[String], len: Int) :String = {
        for (i <- 0 until arr.length) {
            if ((arr(i)).length == len) {
                return (arr(i))
            }
        }
        return ""
    }

}

class Data(input: String) {
    var first : Array[String] = input.split('|')(0).split(' ')
    var second : Array[String] = input.split('|')(1).split(' ')
}