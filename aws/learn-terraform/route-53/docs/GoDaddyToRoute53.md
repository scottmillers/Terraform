# How to transfer your domain from GoDaddy to Route 53


I want to buy a domain on GoDaddy and then use Route53 to manage my DNS records.

Options seem to be
- Use GoDaddy as the registrar and Route53 as the DNS service
- Transfer the domain from GoDaddy to Route53
    - This is the best option if you want to manage your domain and DNS records in the same place
    - But due to ICANN rules, you can't transfer a domain within 60 days of buying it
    - So that is not an option



## Use GoDaddy as the registrar and Route53 as the DNS service

1. Go to Route53 and create a Hosted Zone
2. Get the 4 Name Servers from Route53
3. Go to GoDaddy and update the Name Servers to the 4 Name Servers from Route53




## Transfer the Domain from GoDaddy to Route53

1. Go to GoDaddy and go to manage your domain.  
2. Click the 3 dots on the right of your domain and select **Turn Lock Off**. Select continue when you get the warning.
3. This failed saying I needed to wait 60 days. 

