class Snafu
    MULTIPLIERS = {
        "2" => 2,
        "1" => 1,
        "0" => 0,
        "-" => -1,
        "=" => -2
    }

    def self.from_string(input)
        power_of_five = 0
        result = 0
        input.chars.reverse.each do |digit|
            result += (5 ** power_of_five) * MULTIPLIERS[digit]

            power_of_five += 1
        end
        result
    end

    def self.to_string(input)
        result = ""

        sum = 0
        first_digit = 2
        first = 5 ** 19 * first_digit
        result = "#{first_digit}"
        sum += first

        second_digit = 0
        second = 5 ** 18 * second_digit
        result = "#{result}#{second_digit}"
        sum += second

        third_digit = -2
        third = 5 ** 17 * third_digit
        result = "#{result}="
        sum += third

        forth_digit = 2
        forth = 5 ** 16 * forth_digit
        result = "#{result}#{forth_digit}"
        sum += forth

        fifth_digit = -1
        fifth = 5 ** 15 * fifth_digit
        result = "#{result}-"
        sum += fifth

        sixth_digit = 0
        sixth = 5 ** 15 * sixth_digit
        result = "#{result}#{sixth_digit}"
        sum += sixth

        seventh_digit = 2
        seventh = 5 ** 13 * seventh_digit
        result = "#{result}#{seventh_digit}"
        sum += seventh

        eighth_digit = -1
        eighth = 5 ** 12 * eighth_digit
        result = "#{result}-"
        sum += eighth

        ninth_digit = 0
        ninth = 5 ** 11 * ninth_digit
        result = "#{result}#{ninth_digit}"
        sum += ninth

        tenth_digit = -1
        tenth = 5 ** 10 * tenth_digit
        result = "#{result}-"
        sum += tenth

        eleventh_digit = -1
        eleventh = 5 ** 9 * eleventh_digit
        result = "#{result}-"
        sum += eleventh

        twelve = 5 ** 8 * -1
        result = "#{result}-"
        sum += twelve

        thirteen = 5 ** 7 * 0
        result = "#{result}0"
        sum += thirteen

        fourteen = 5 ** 6 * 2
        result = "#{result}2"
        sum += fourteen

        fifteen = 5 ** 5 * -2
        result = "#{result}="
        sum += fifteen

        sixteen = 5 ** 4 * 2
        result = "#{result}2"
        sum += sixteen

        seventeen = 5 ** 3 * 2
        result = "#{result}2"
        sum += seventeen

        eighteen = 5 ** 2 * -2
        result = "#{result}="
        sum += eighteen

        ninteen = 5 ** 1 * 2
        result = "#{result}2"
        sum += ninteen

        twenty = 5 ** 0 * 1
        result = "#{result}1"
        sum += twenty

        result
    end
end

input = File.readlines(ARGV[0], chomp: true)
sum = input.map { |l| Snafu.from_string(l) }.reduce(&:+)
result = Snafu.to_string(sum)
puts sum
puts result
puts Snafu.from_string(result)
