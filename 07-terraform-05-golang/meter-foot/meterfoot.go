package main
    
    import "fmt"
    	
    func meter_to_foot(meter float64) string {
        foot := fmt.Sprintf("%v", meter * 0.3048 )
        return foot
    }

    func main() {
        fmt.Print("Enter the length in m: ")
        var input float64
        fmt.Scanf("%f", &input)
        fmt.Println("Length = " + meter_to_foot(input) + " ft")    
    }

    