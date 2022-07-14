package main
    
    import "testing"

    func Test_meter_to_foot(t *testing.T){
        
        result := meter_to_foot(100)
        if result != "30.48" {
            t.Errorf("meter_to_foot(100)=%T; want 30.48", result)
        }
        
    }
