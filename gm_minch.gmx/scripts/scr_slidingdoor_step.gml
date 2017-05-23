// define direction and distance in creation script

if (self.status == "active")
{
    self.x += self.slidingSpeed;
    
    show_debug_message(string(self.x) + " / " + string(self.slidingDistance) + " @ " + string(self.slidingSpeed));
    
    if ((self.slidingSpeed > 0) && (self.x >= self.slidingDistance))
    {
        status = "inactive";
    }
    else if ((self.slidingSpeed < 0) && (self.x <= self.slidingDistance))
    {
        status = "inactive";
    }
}
