#ifndef __GDT_H
#define __GDT_H

    class GlobalDescriptorTable
    {
        public:
            class SegmentDescriptor
            {
                private:
                    uint16_t limit_lo;
                    uint16_t base_lo;
                    uint8_t base_hi;
                    uint8_t type;
                    uint8_t flags_limit_hi;
                    uint8_t base_vhi;
                public:
                    SegmentDescriptor(uint32_t base, uint32_t limit, uint8_t type);
                    uint32_t Base();
                    uint32_t Limit();
            }__attribute__((packed)); // make sure it is byte perfect

            SegmentDescriptor nullSegmentSelector; // segment for null
            SegmentDescriptor unusedSegmentSelector; // segment not used
            SegmentDescriptor codeSegmentSelector; // segment for code
            SegmentDescriptor dataSegmentSelector; // segment for data

        public:
            GlobalDescriptorTable();
            ~GlobalDescriptorTable();

            uint16_t CodeSegmentSelector();
            uint16_t DataSegmentSelector();
    };

#endif